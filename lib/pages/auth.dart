import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starter_app/core/viewmodels/products.dart';
import 'package:starter_app/widgets/ui_elements/popup-modal.dart';
import 'package:starter_app/widgets/ui_elements/progress_button.dart';

enum AuthMode { SignUp, LogIn }

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
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  AuthMode _authMode = AuthMode.LogIn;

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
                        padding:
                            EdgeInsets.symmetric(horizontal: paddingWidth / 2),
                        child: Form(
                            key: _formKey,
                            child: Column(children: <Widget>[
                              _buildEmailTextField(),
                              SizedBox(
                                height: 10.0,
                              ),
                              // _authMode == AuthMode.SignUp? _buildConfirmEmailTextField() : Container(),
                              // SizedBox(
                              //   height: 10.0,
                              // ),
                              _buildPasswordTextField(),
                              SizedBox(
                                height: 10.0,
                              ),
                              _authMode == AuthMode.SignUp
                                  ? _buildConfirmPasswordTextField()
                                  : Container(),

                              _buildAcceptTermsSwitch(),
                              SizedBox(
                                height: 10.0,
                              ),
                              FlatButton(
                                child: Text(
                                    'Switch to ${_authMode == AuthMode.LogIn ? "SignUp" : "Signin"}'),
                                onPressed: () {
                                  setState(() {
                                    _authMode = _authMode == AuthMode.LogIn
                                        ? AuthMode.SignUp
                                        : AuthMode.LogIn;
                                  });
                                },
                              ),
                              _buildSubmitForm(context),
                            ]))))),
          ),
        ));
  }

  Widget _buildSubmitForm(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
        builder: (context, child, ProductsModel model) {
      return ProgressButton(
          buttonText: _authMode == AuthMode.LogIn ? "Login" : "Signup",
          asyncFunctionCall: () async => await _submitForm(
              context, model.login, model.signUp, model.autoAuthenticateUser));
      // return RaisedButton(
      //   child: Text("Login"),
      //   onPressed: () => _submitForm(context, model.login, model.signUp),
      // );
    });
  }

  Future<bool> _submitForm(context, Function login, Function signUp,
      Function autoAuthenticateUser) async {
    var isAuth = await autoAuthenticateUser();
    if (isAuth == true) {
      Navigator.pushReplacementNamed(context, "/home");
      return true;
    }
    if (!_formKey.currentState.validate()) {
      return false;
    }
    _formKey.currentState.save();
    Map<String, dynamic> result;
    if (this._authMode == AuthMode.LogIn) {
      result = await login(_formData['username'], _formData['password']);
    } else {
      result = await signUp(_formData['username'], _formData['password']);
    }

    if (result['success'] == false) {
      showAlertDialog(context, "Error Message", result['error']);
      return false;
    } else {
      Navigator.pushReplacementNamed(context, "/home");
    }

    return true;
  }

  Widget _buildAcceptTermsSwitch() {
    return SwitchListTile(
      title: Text('Accept Terms'),
      value: _acceptTerms,
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
          _formData['acceptTerms'] = _acceptTerms;
        });
      },
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'E-Mail', filled: true, fillColor: Colors.white),
        keyboardType: TextInputType.emailAddress,
        controller: _emailTextEditingController,
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                  .hasMatch(value)) {
            {
              return "Please enter a valid email.";
            }
          }
        },
        onSaved: (String value) {
          _formData['username'] = value;
        });
  }

  Widget _buildConfirmEmailTextField() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Confirm E-Mail', filled: true, fillColor: Colors.white),
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (_emailTextEditingController.text != value) {
            {
              return "Email does not match.";
            }
          }
        },
        onSaved: (String value) {});
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Password', filled: true, fillColor: Colors.white),
        obscureText: true,
        controller: _passwordTextEditingController,
        validator: (String value) {
          if (value.isEmpty) {
            {
              return "Password is required";
            }
          }
        },
        onSaved: (String value) => _formData['password'] = value);
  }

  Widget _buildConfirmPasswordTextField() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Confirm E-Mail', filled: true, fillColor: Colors.white),
        obscureText: true,
        validator: (String value) {
          if (_passwordTextEditingController.text != value) {
            {
              return "Password does not match.";
            }
          }
        },
        onSaved: (String value) {});
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
