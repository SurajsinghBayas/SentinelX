// ============================================================
// SentinelX — Auth Repository
// Orchestrates remote datasource + local token persistence.
// ============================================================

import 'dart:convert';

import '../datasources/remote/auth_remote_datasource.dart';
import '../models/auth_models.dart';
import '../../core/network/dio_client.dart';
import '../../core/storage/hive_service.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    String role = 'operator',
  });
  Future<UserModel?> getMe();
  Future<void> logout();
  UserModel? getCachedUser();
  bool get isAuthenticated;
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;

  AuthRepositoryImpl({AuthRemoteDataSource? dataSource})
      : _dataSource = dataSource ?? AuthRemoteDataSourceImpl();

  @override
  Future<UserModel> login(String email, String password) async {
    // 1. Authenticate → get token
    final token = await _dataSource.login(
      LoginRequest(email: email, password: password),
    );

    // 2. Persist token
    await HiveService.saveToken(token.accessToken);

    // 3. Rebuild Dio so subsequent calls use the new token
    DioClient.reset();

    // 4. Fetch user profile
    final user = await _dataSource.getMe();
    await HiveService.saveUserJson(jsonEncode(user.toJson()));
    return user;
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    String role = 'operator',
  }) async {
    final user = await _dataSource.register(
      RegisterRequest(name: name, email: email, password: password, role: role),
    );
    return user;
  }

  @override
  Future<UserModel?> getMe() async {
    try {
      final user = await _dataSource.getMe();
      await HiveService.saveUserJson(jsonEncode(user.toJson()));
      return user;
    } catch (_) {
      return getCachedUser();
    }
  }

  @override
  UserModel? getCachedUser() {
    final json = HiveService.getUserJson();
    if (json == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    await HiveService.clearAuth();
    DioClient.reset();
  }

  @override
  bool get isAuthenticated => HiveService.isAuthenticated;
}
