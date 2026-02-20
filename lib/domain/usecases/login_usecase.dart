import 'package:global_vin/core/errors/failures.dart';
import 'package:global_vin/domain/entities/user_entity.dart';
import 'package:global_vin/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase({required AuthRepository repository}) : _repository = repository;

  Future<({UserEntity? user, Failure? failure})> call({
    required String email,
    required String password,
  }) {
    return _repository.login(email: email, password: password);
  }
}
