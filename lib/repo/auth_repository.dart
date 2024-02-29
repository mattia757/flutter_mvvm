
import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../resources/app_urls.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      print(data.runtimeType);
      dynamic response = await _apiServices.getPostApiResponse(AppUrls.loginApiEndpointUrl, data);

      return response;
    } catch(e) {
      rethrow;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response = _apiServices.getPostApiResponse(AppUrls.registerApiEndpointUrl, data);

      return response;
    } catch(e) {
      rethrow;
    }
  }
}