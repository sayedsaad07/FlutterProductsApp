import 'package:flutter/material.dart';

enum DialogMode { YesNo, OK }

Widget showSnackBar(context, String text){
   Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(text)));
}

Future<void> showAlertDialog(BuildContext context, String title, String content) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        // SingleChildScrollView(
        //   child: ListBody(
        //     children: <Widget>[
        //       Text('You will never be satisfied.'),
        //       Text('You\’re like me. I’m never satisfied.'),
        //     ],
        //   ),
        // ),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}