import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class DetailsListWatchedMovies {
  int? idList;

  Future<SharedPreferences> getInstancySharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> init() async {
    final preferences = await getInstancySharedPreferences();
    idList = preferences.getInt(Constants.sharedPreferencesIdListWatchMovies);
  }

  Future<void> saveIdListWatchMovies({required int idList}) async {
    final preferences = await getInstancySharedPreferences();
    await preferences.setInt(
        Constants.sharedPreferencesIdListWatchMovies, idList);
  }

  Future<void> resetIdListWatchMovies() async {
    final preferences = await getInstancySharedPreferences();
    await preferences.remove(Constants.sharedPreferencesIdListWatchMovies);
  }
}
