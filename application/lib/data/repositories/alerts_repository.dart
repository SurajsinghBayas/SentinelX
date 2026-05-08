// ============================================================
// SentinelX — Alerts Repository
// ============================================================

import '../datasources/remote/alerts_remote_datasource.dart';
import '../models/alert_models.dart';

abstract class AlertsRepository {
  Future<AlertListResponse> listAlerts({
    int skip = 0,
    int limit = 20,
    bool unacknowledgedOnly = false,
  });
  Future<AcknowledgeAlertResponse> acknowledgeAlert(String alertId);
}

class AlertsRepositoryImpl implements AlertsRepository {
  final AlertsRemoteDataSource _dataSource;

  AlertsRepositoryImpl({AlertsRemoteDataSource? dataSource})
      : _dataSource = dataSource ?? AlertsRemoteDataSourceImpl();

  @override
  Future<AlertListResponse> listAlerts({
    int skip = 0,
    int limit = 20,
    bool unacknowledgedOnly = false,
  }) =>
      _dataSource.listAlerts(
        skip: skip,
        limit: limit,
        unacknowledgedOnly: unacknowledgedOnly,
      );

  @override
  Future<AcknowledgeAlertResponse> acknowledgeAlert(String alertId) =>
      _dataSource.acknowledgeAlert(alertId);
}
