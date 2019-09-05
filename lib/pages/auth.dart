import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  String userName = '';
  String password = '';
  bool _acceptTerms = false;
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 700.0 ? 500 : deviceWidth * 0.95;
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            decoration: background_image(),
            padding: EdgeInsets.all(10.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Container(
                        width: targetWidth,
                        child: Column(children: <Widget>[
                          userName_input(),
                          SizedBox(
                            height: 10.0,
                          ),
                          password_input(),
                          acceptTerms_switch(),
                          login_submit(context)
                        ])))),
          ),
        ));
  }

  RaisedButton login_submit(BuildContext context) {
    return RaisedButton(
      child: Text("Login"),
      onPressed: () {
        Navigator.pushReplacementNamed(context, "/");
      },
    );
  }

  SwitchListTile acceptTerms_switch() {
    return SwitchListTile(
      title: Text('Accept Terms'),
      value: _acceptTerms,
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
    );
  }

  TextField password_input() {
    return TextField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      onChanged: (String value) {
        setState(() {
          password = value;
        });
      },
    );
  }

  TextField userName_input() {
    return TextField(
      decoration: InputDecoration(
          labelText: 'User Name', filled: true, fillColor: Colors.white),
      onChanged: (String value) {
        setState(() {
          userName = value;
        });
      },
    );
  }

  BoxDecoration background_image() {
    return BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage('assets/images/background.jpg')));
  }
}
