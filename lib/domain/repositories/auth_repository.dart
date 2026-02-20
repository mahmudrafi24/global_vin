import 'package:global_vin/core/errors/failures.dart';
import 'package:global_vin/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<({UserEntity? user, Failure? failure})> login({
    required String email,
    required String password,
  });

  Future<({UserEntity? user, Failure? failure})> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();
}
