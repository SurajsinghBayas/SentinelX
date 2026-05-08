// ============================================================
// SentinelX — Dashboard Repository
// ============================================================

import '../datasources/remote/dashboard_remote_datasource.dart';
import '../models/dashboard_models.dart';
import '../models/threat_models.dart';

abstract class DashboardRepository {
  Future<DashboardStats> getStats();
  Future<ThreatListResponse> getThreats({int skip = 0, int limit = 20});
  Future<DashboardTrends> getTrends({int days = 7});
}

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _dataSource;

  DashboardRepositoryImpl({DashboardRemoteDataSource? dataSource})
      : _dataSource = dataSource ?? DashboardRemoteDataSourceImpl();

  @override
  Future<DashboardStats> getStats() => _dataSource.getStats();

  @override
  Future<ThreatListResponse> getThreats({int skip = 0, int limit = 20}) =>
      _dataSource.getThreats(skip: skip, limit: limit);

  @override
  Future<DashboardTrends> getTrends({int days = 7}) =>
      _dataSource.getTrends(days: days);
}
