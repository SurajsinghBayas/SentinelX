// ============================================================
// SentinelX — Dashboard Remote Datasource
// ============================================================

import 'package:dio/dio.dart';

import '../../../core/config/api_config.dart';
import '../../../core/network/dio_client.dart';
import '../../models/dashboard_models.dart';
import '../../models/threat_models.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardStats> getStats();
  Future<ThreatListResponse> getThreats({int skip = 0, int limit = 20});
  Future<DashboardTrends> getTrends({int days = 7});
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio _dio;

  DashboardRemoteDataSourceImpl({Dio? dio}) : _dio = dio ?? DioClient.instance;

  @override
  Future<DashboardStats> getStats() async {
    try {
      final response = await _dio.get(ApiConfig.dashboardStats);
      return DashboardStats.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<ThreatListResponse> getThreats({int skip = 0, int limit = 20}) async {
    try {
      final response = await _dio.get(
        ApiConfig.dashboardThreats,
        queryParameters: {'skip': skip, 'limit': limit},
      );
      return ThreatListResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<DashboardTrends> getTrends({int days = 7}) async {
    try {
      final response = await _dio.get(
        ApiConfig.dashboardTrends,
        queryParameters: {'days': days},
      );
      return DashboardTrends.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
