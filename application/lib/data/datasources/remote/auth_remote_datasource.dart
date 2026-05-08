// ============================================================
// SentinelX — Auth Remote Datasource
// ============================================================

import 'package:dio/dio.dart';

import '../../../core/config/api_config.dart';
import '../../../core/network/dio_client.dart';
import '../../models/auth_models.dart';

abstract class AuthRemoteDataSource {
  Future<TokenModel> login(LoginRequest request);
  Future<UserModel> register(RegisterRequest request);
  Future<UserModel> getMe();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl({Dio? dio}) : _dio = dio ?? DioClient.instance;

  @override
  Future<TokenModel> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        ApiConfig.authLogin,
        data: {
          'email': request.email,
          'password': request.password,
        },
      );
      return TokenModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<UserModel> register(RegisterRequest request) async {
    try {
      final response = await _dio.post(
        ApiConfig.authRegister,
        data: {
          'name': request.name,
          'email': request.email,
          'password': request.password,
          'role': request.role,
        },
      );
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<UserModel> getMe() async {
    try {
      final response = await _dio.get(ApiConfig.authMe);
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
