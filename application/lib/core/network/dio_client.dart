// ============================================================
// SentinelX — Dio HTTP Client
// ============================================================

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/api_config.dart';
import '../storage/hive_service.dart';

class DioClient {
  DioClient._();

  static Dio? _dio;

  static Dio get instance {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.apiBase,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // ── Auth Interceptor ────────────────────────────────────────────
    dio.interceptors.add(_AuthInterceptor(dio));

    // ── Retry Interceptor ───────────────────────────────────────────
    dio.interceptors.add(_RetryInterceptor(dio));

    // ── Logger (debug only) ─────────────────────────────────────────
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: false,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }

    return dio;
  }

  /// Rebuild Dio after token update (e.g., after login)
  static void reset() => _dio = null;
}

// ── Auth Interceptor ─────────────────────────────────────────────────────────

class _AuthInterceptor extends Interceptor {
  final Dio _dio;

  _AuthInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = HiveService.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token expired — clear stored auth state
      // Navigation to login is handled at the provider layer
      HiveService.clearAuth();
    }
    handler.next(err);
  }
}

// ── Retry Interceptor ─────────────────────────────────────────────────────────

class _RetryInterceptor extends Interceptor {
  final Dio _dio;
  static const int _maxRetries = 2;

  _RetryInterceptor(this._dio);

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final extra = err.requestOptions.extra;
    final retryCount = (extra['retryCount'] as int?) ?? 0;

    final shouldRetry = _isRetryable(err) && retryCount < _maxRetries;

    if (shouldRetry) {
      err.requestOptions.extra['retryCount'] = retryCount + 1;
      await Future.delayed(
        ApiConfig.retryDelay * (retryCount + 1), // exponential backoff
      );
      try {
        final response = await _dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        // Fall through to original error
      }
    }

    handler.next(err);
  }

  bool _isRetryable(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.response?.statusCode != null &&
            err.response!.statusCode! >= 500);
  }
}

// ── API Error Parsing ─────────────────────────────────────────────────────────

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? detail;

  const ApiException({
    required this.message,
    this.statusCode,
    this.detail,
  });

  factory ApiException.fromDioException(DioException e) {
    if (e.response != null) {
      final data = e.response?.data;
      final msg = (data is Map)
          ? (data['detail'] ?? data['error'] ?? 'Request failed')
          : 'Request failed';
      return ApiException(
        message: msg.toString(),
        statusCode: e.response?.statusCode,
        detail: data?.toString(),
      );
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const ApiException(
          message: 'Connection timed out. Check your network.',
          statusCode: null,
        );
      case DioExceptionType.connectionError:
        return const ApiException(
          message: 'Cannot reach server. Check your connection.',
          statusCode: null,
        );
      default:
        return ApiException(
          message: e.message ?? 'An unexpected error occurred.',
          statusCode: null,
        );
    }
  }

  @override
  String toString() => 'ApiException($statusCode): $message';
}
