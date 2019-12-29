import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starter_app/core/viewmodels/products.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'userName': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String userName = '';
  String password = '';
  bool _acceptTerms = false;
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 700.0 ? 500 : deviceWidth * 0.95;
    final double paddingWidth = deviceWidth - targetWidth;
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
                        padding: EdgeInsets.symmetric(
                                    horizontal: paddingWidth / 2),
                        child: Form(
                            key: _formKey,
                            child: Column(
                                children: <Widget>[
                                  userName_input(),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  password_input(),
                                  acceptTerms_switch(),
                                  login_submit(context)
                                ]))))),
          ),
        ));
  }

  Widget login_submit(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
        builder: (context, child, ProductsModel model) {
      return RaisedButton(
        child: Text("Login"),
        onPressed: () => _submitForm(model.login),
      );
    });
  }

  _submitForm(Function login) {
       if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    login(_formData['username'] , _formData['password']);
    Navigator.pushReplacementNamed(context, "/");
  }

  Widget acceptTerms_switch() {
    return SwitchListTile(
      title: Text('Accept Terms'),
      value: _acceptTerms,
      onChanged: (bool value) {
        setState(() => _formData['acceptTerms'] = value);
      },
    );
  }

  Widget password_input() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Password', filled: true, fillColor: Colors.white),
        initialValue: '',
        obscureText: true,
        validator: (String value) {
          if (value.isEmpty) {
            {
              return "Password is required";
            }
          }
        },
        onSaved: (String value) => _formData['password'] = value);
  }

  Widget userName_input() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'User Name', filled: true, fillColor: Colors.white),
        initialValue: '',
        validator: (String value) {
          if (value.isEmpty) {
            {
              return "username is required";
            }
          }
        },
        onSaved: (String value) {
          _formData['username'] = value;
        });
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
