import 'package:movies_pop/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSession {
  String? username;
  int? id;
  String? sessionId;

  Future<SharedPreferences> getInstancySharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> init() async {
    final preferences = await getInstancySharedPreferences();
    sessionId = preferences.getString(Constants.sharedPreferencesSessionId);
    username = preferences.getString(Constants.sharedPreferencesUsername);
    id = preferences.getInt(Constants.sharedPreferencesAccountId);
    print(id);

    // print('========================');
    // print(sessionId);
  }

  Future<void> saveSessionId({required String sessionId}) async {
    final preferences = await getInstancySharedPreferences();
    await preferences.setString(
        Constants.sharedPreferencesSessionId, sessionId);
  }

  Future<void> saveDetailsAccount(
      {required String username, required int id}) async {
    final preferences = await getInstancySharedPreferences();
    await preferences.setString(Constants.sharedPreferencesUsername, username);
    await preferences.setInt(Constants.sharedPreferencesAccountId, id);
  }

  Future<void> resetSessionId({required String sessionId}) async {
    final preferences = await getInstancySharedPreferences();
    await preferences.remove(Constants.sharedPreferencesUsername);
    await preferences.remove(Constants.sharedPreferencesAccountId);
    await preferences.remove(Constants.sharedPreferencesSessionId);
  }
}
