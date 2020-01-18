import 'package:flutter/material.dart';

class User {
  final String id;
  final String email;
  final String idToken;

  User(
      {@required this.id,
      @required this.email,
      @required this.idToken});
}

class AuthHttpResponseData {
  final bool success;
  final String error;
  AuthHttpResponseData({@required this.success, this.error});
}
