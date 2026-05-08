// ============================================================
// SentinelX — Alerts Remote Datasource
// ============================================================

import 'package:dio/dio.dart';

import '../../../core/config/api_config.dart';
import '../../../core/network/dio_client.dart';
import '../../models/alert_models.dart';

abstract class AlertsRemoteDataSource {
  Future<AlertListResponse> listAlerts({
    int skip = 0,
    int limit = 20,
    bool unacknowledgedOnly = false,
  });
  Future<AcknowledgeAlertResponse> acknowledgeAlert(String alertId);
}

class AlertsRemoteDataSourceImpl implements AlertsRemoteDataSource {
  final Dio _dio;

  AlertsRemoteDataSourceImpl({Dio? dio}) : _dio = dio ?? DioClient.instance;

  @override
  Future<AlertListResponse> listAlerts({
    int skip = 0,
    int limit = 20,
    bool unacknowledgedOnly = false,
  }) async {
    try {
      final response = await _dio.get(
        ApiConfig.alerts,
        queryParameters: {
          'skip': skip,
          'limit': limit,
          'unacknowledged_only': unacknowledgedOnly,
        },
      );
      return AlertListResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<AcknowledgeAlertResponse> acknowledgeAlert(String alertId) async {
    try {
      final response = await _dio.post(
        ApiConfig.alertAcknowledge(alertId),
      );
      return AcknowledgeAlertResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
