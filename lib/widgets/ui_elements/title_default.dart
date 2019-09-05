import 'package:flutter/cupertino.dart';

class TitleDefault extends StatelessWidget {
  final String _title;
  TitleDefault(this._title);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
          fontSize: 36.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
    );
  }
}
