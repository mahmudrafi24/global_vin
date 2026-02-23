import 'package:core_kit/core_kit.dart';
import 'package:core_kit/network/request_input.dart';
import 'package:global_vin/core/errors/exceptions.dart';

class ApiClient {
  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await DioService.instance.request(
      input: RequestInput(
        endpoint: endpoint,
        method: RequestMethod.GET,
        requiresToken: true,
      ),
      responseBuilder: (data) => data as Map<String, dynamic>,
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final response = await DioService.instance.request(
      input: RequestInput(
        endpoint: endpoint,
        method: RequestMethod.POST,
        jsonBody: body,
        requiresToken: true,
      ),
      responseBuilder: (data) => data as Map<String, dynamic>,
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final response = await DioService.instance.request(
      input: RequestInput(
        endpoint: endpoint,
        method: RequestMethod.PUT,
        jsonBody: body,
        requiresToken: true,
      ),
      responseBuilder: (data) => data as Map<String, dynamic>,
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await DioService.instance.request(
      input: RequestInput(
        endpoint: endpoint,
        method: RequestMethod.DELETE,
        requiresToken: true,
      ),
      responseBuilder: (data) => data as Map<String, dynamic>,
    );
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(
      ResponseState<Map<String, dynamic>?> response) {
    if (response.isSuccess && response.data != null) {
      return response.data!;
    }
    throw ServerException(
      message: response.message ?? 'Something went wrong',
      statusCode: response.statusCode,
    );
  }
}
