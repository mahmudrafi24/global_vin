import 'package:global_vin/core/errors/exceptions.dart';
import 'package:global_vin/core/errors/failures.dart';
import 'package:global_vin/core/network/network_info.dart';
import 'package:global_vin/data/providers/remote/auth_provider.dart';
import 'package:global_vin/data/providers/local/storage_provider.dart';
import 'package:global_vin/domain/entities/user_entity.dart';
import 'package:global_vin/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthProvider _authProvider;
  final StorageProvider _storageProvider;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl({
    required AuthProvider authProvider,
    required StorageProvider storageProvider,
    required NetworkInfo networkInfo,
  })  : _authProvider = authProvider,
        _storageProvider = storageProvider,
        _networkInfo = networkInfo;

  @override
  Future<({UserEntity? user, Failure? failure})> login({
    required String email,
    required String password,
  }) async {
    if (!await _networkInfo.isConnected) {
      return (user: null, failure: const NetworkFailure());
    }
    try {
      final user = await _authProvider.login(email: email, password: password);
      return (user: user, failure: null);
    } on ServerException catch (e) {
      return (user: null, failure: ServerFailure(message: e.message));
    }
  }

  @override
  Future<({UserEntity? user, Failure? failure})> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (!await _networkInfo.isConnected) {
      return (user: null, failure: const NetworkFailure());
    }
    try {
      final user = await _authProvider.register(
        name: name,
        email: email,
        password: password,
      );
      return (user: user, failure: null);
    } on ServerException catch (e) {
      return (user: null, failure: ServerFailure(message: e.message));
    }
  }

  @override
  Future<void> logout() async {
    await _storageProvider.clearAll();
  }
}
