import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/response/api_responses.dart';
import 'package:flutter_mvvm/model/movies_list_model.dart';
import 'package:flutter_mvvm/repo/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();
  ApiResponse<MoviesListModel> movieList = ApiResponse.loading();

  setMovieStatus(ApiResponse<MoviesListModel> response) {
    movieList = response;
    notifyListeners();
  }

  Future<void> fetchMoviesList() async {
    setMovieStatus(ApiResponse.loading());
    _myRepo.fetchMovies().then((value) {
      setMovieStatus(ApiResponse.completed(value));
    }).onError((error, stackTrace) {});
  }
}