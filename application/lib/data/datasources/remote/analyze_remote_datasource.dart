// ============================================================
// SentinelX — Analyze Remote Datasource
// Sends SMS / Call / Email events to backend for AI analysis.
// ============================================================

import 'package:dio/dio.dart';

import '../../../core/config/api_config.dart';
import '../../../core/network/dio_client.dart';
import '../../models/threat_models.dart';

abstract class AnalyzeRemoteDataSource {
  Future<ThreatAnalysisResponse> analyzeSms(SmsAnalysisRequest request);
  Future<ThreatAnalysisResponse> analyzeCall(CallAnalysisRequest request);
  Future<ThreatAnalysisResponse> analyzeEmail(EmailAnalysisRequest request);
}

class AnalyzeRemoteDataSourceImpl implements AnalyzeRemoteDataSource {
  final Dio _dio;

  AnalyzeRemoteDataSourceImpl({Dio? dio}) : _dio = dio ?? DioClient.instance;

  @override
  Future<ThreatAnalysisResponse> analyzeSms(SmsAnalysisRequest request) async {
    try {
      final response = await _dio.post(
        ApiConfig.analyzeSms,
        data: {
          'sender': request.sender,
          'message': request.message,
          'async_processing': request.asyncProcessing,
        },
      );
      return ThreatAnalysisResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<ThreatAnalysisResponse> analyzeCall(CallAnalysisRequest request) async {
    try {
      final response = await _dio.post(
        ApiConfig.analyzeCall,
        data: {
          'transcript': request.transcript,
          if (request.callerId != null) 'caller_id': request.callerId,
          if (request.durationSeconds != null)
            'duration_seconds': request.durationSeconds,
        },
      );
      return ThreatAnalysisResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<ThreatAnalysisResponse> analyzeEmail(EmailAnalysisRequest request) async {
    try {
      final response = await _dio.post(
        ApiConfig.analyzeEmail,
        data: {
          'sender': request.sender,
          'subject': request.subject,
          'body': request.body,
          'async_processing': request.asyncProcessing,
        },
      );
      return ThreatAnalysisResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
