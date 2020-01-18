import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_app/core/models/user.dart';

setAuthenticatedUserInfo(String id, String email, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userToken', token);
  await prefs.setString('userId', id);
  await prefs.setString('userEmail', email);
}

removeAuthenticatedUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('userToken');
  await prefs.remove('userId');
  // await prefs.remove('userEmail');
}

Future<User> getAuthenticatedUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('userToken');
  var id = prefs.getString('userId');
  var email = prefs.getString('userEmail');
  if (token == null) return null;
  return new User(email: email, id: id, idToken: token);
}
