import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool _isLoggedin = false;
  bool get isLoggedin {
    return _isLoggedin;
  }

  void login() {}
}
