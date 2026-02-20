import 'package:global_vin/core/network/api_client.dart';
import 'package:global_vin/data/providers/remote/auth_provider.dart';
import 'package:global_vin/data/providers/remote/user_provider.dart';

class RemoteDatasource {
  late final AuthProvider authProvider;
  late final UserProvider userProvider;

  RemoteDatasource({required ApiClient apiClient}) {
    authProvider = AuthProvider(apiClient: apiClient);
    userProvider = UserProvider(apiClient: apiClient);
  }
}
