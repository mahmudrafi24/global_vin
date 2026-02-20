import 'package:core_kit/core_kit.dart';
import 'package:get/get.dart';
import 'package:global_vin/services/storage_service.dart';

class TokenProviderImpl implements TokenProvider {
  StorageService get _storage => Get.find<StorageService>();

  @override
  Future<String>? Function() get accessToken =>
      () async => _storage.read<String>('access_token') ?? '';

  @override
  set accessToken(Future<String>? Function() value) {}

  @override
  Future<String>? Function() get refreshToken =>
      () async => _storage.read<String>('refresh_token') ?? '';

  @override
  set refreshToken(Future<String>? Function() value) {}

  @override
  Future<void> Function(dynamic) get updateTokens => (params) async {
        final accessToken = params['accessToken'] as String;
        final refreshToken = params['refreshToken'] as String;
        await _storage.write('access_token', accessToken);
        await _storage.write('refresh_token', refreshToken);
      };

  @override
  set updateTokens(Future<void> Function(dynamic) value) {}
}
