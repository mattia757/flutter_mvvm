import 'package:flutter_mvvm/data/network/base_api_services.dart';
import 'package:flutter_mvvm/data/network/network_api_services.dart';
import 'package:flutter_mvvm/model/movies_list_model.dart';
import 'package:flutter_mvvm/resources/app_urls.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> fetchMovies() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
        AppUrls.moviesListApiEndpointUrl,
      );

          return response = MoviesListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}