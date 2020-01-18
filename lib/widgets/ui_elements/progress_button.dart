import 'dart:async';

import 'package:flutter/material.dart';

class ProgressButton extends StatefulWidget {
  final Function asyncFunctionCall;
  final String buttonText;
  ProgressButton({@required this.buttonText, @required this.asyncFunctionCall});

  @override
  State<StatefulWidget> createState() {
    return new ProgressButtonState();
  }
}

class ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  int _state = 0;
  double _width = double.infinity;
  GlobalKey _globalKey = new GlobalKey();
  Animation _animation;
  AnimationController _controller;
  double initialWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    Widget materialButton = new MaterialButton(
      key: _globalKey,
      child: setUpButtonChild(),
      onPressed: () {
        initialWidth = initialWidth == 0.0
            ? _globalKey.currentContext.size.width
            : initialWidth;
        setState(() {
          if (_state == 0) {
            animateButton();
          }
        });
      },
      elevation: 4.0,
      minWidth: _width,
      height: 48.0,
      color: Colors.lightBlue,
    );
    return new PhysicalModel(
      color: Colors.lightBlue,
      borderRadius: BorderRadius.circular(25.0),
      child: materialButton,
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        widget.buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  _animateButtonWidth(double start, double end) {
    _animation = Tween(begin: start, end: end).animate(_controller);
    _animation.addListener(() {
      setState(() {
        _width = initialWidth - ((initialWidth - 48.0) * _animation.value);
      });
    });
    _controller.forward();
  }

  Future<void> animateButton() async {
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animateButtonWidth(0.0, 1.0);
    setState(() {
      _state = 1;
    });

    bool result = await widget.asyncFunctionCall();
    setState(() {
      if (result == false) {
        _state = 0;
        _animateButtonWidth(1.0, 0.0);
      } else {
        _state = 2;
      }
    });
  }
}
