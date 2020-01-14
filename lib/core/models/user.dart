import 'package:flutter/material.dart';

class User {
  final String id;
  final String email;
  final String password;
final String idToken;

  User({@required this.id , @required this.email , @required this.password, @required this.idToken});
} 


class AuthHttpResponseData{
  final bool success;
  final String error;
  AuthHttpResponseData({@required this.success , this.error});
}
