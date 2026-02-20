import 'package:global_vin/core/errors/failures.dart';
import 'package:global_vin/domain/entities/user_entity.dart';
import 'package:global_vin/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase({required AuthRepository repository}) : _repository = repository;

  Future<({UserEntity? user, Failure? failure})> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repository.register(name: name, email: email, password: password);
  }
}
