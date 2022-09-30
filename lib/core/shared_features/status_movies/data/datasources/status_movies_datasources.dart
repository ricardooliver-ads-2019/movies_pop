import 'package:movies_pop/core/network/http_client_response.dart';

abstract class StatusMoviesDatasources {
  Future<HttpClientResponse> getStatusMovies({required int movieId});
  Future<HttpClientResponse> checkMovieInMyListWatchedMovies(
      {required int movieId});
  Future<HttpClientResponse> addMovieToWatchedMoviesList(
      {required int movieId});
  Future<HttpClientResponse> removeMovieToWatchedMoviesList(
      {required int movieId});
  Future<HttpClientResponse> addMovieToWatchMoviesList({required int movieId});
  Future<HttpClientResponse> removeMovieToWatchMoviesList(
      {required int movieId});
}
