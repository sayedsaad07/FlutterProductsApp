import 'package:flutter/material.dart';
import 'package:starter_app/core/viewmodels/local-settings.dart';

Widget logoutTile(context ) {
  return ListTile(
    leading: Icon(Icons.lock_open),
    title: Text("logout"),
    onTap: () {
      removeAuthenticatedUserInfo();
      Navigator.pushReplacementNamed(context, "/auth");
    },
  );
}
