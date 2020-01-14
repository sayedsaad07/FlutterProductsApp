import 'dart:async';

import 'package:flutter/material.dart';

class ProgressButton extends StatefulWidget {
  final Function asyncFunctionCall;
  final String buttonText;
  ProgressButton({@required this.buttonText , @required this.asyncFunctionCall});

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

  _resetState() {
    _state = 0;
    _width = double.infinity;
  }

  @override
  Widget build(BuildContext context) {
    Widget materialButton = new MaterialButton(
      key: _globalKey,
      child: setUpButtonChild(),
      onPressed: () {
        setState(() {
          if (_state == 0) {
            animateButton();
          }
        });
      },
      elevation: 4.0,
      minWidth: _width,
      height: 48.0,
      color: Colors.lightGreen,
    );
    return new PhysicalModel(
      color: Colors.lightGreen,
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

  Future<void> animateButton() async {
    double initialWidth = _globalKey.currentContext.size.width;
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addListener(() {
      setState(() {
        _width = initialWidth - ((initialWidth - 48.0) * _animation.value);
      });
    });
    _controller.forward();

    setState(() {
      _state = 1;
    });

    // Timer(Duration(milliseconds: 3300), () {
    //   setState(() {
    //     _state = 2;
    //   });
    // });

    bool result = await widget.asyncFunctionCall();
    setState(() {
      if (result == false)
       {_resetState();}
      else
        {_state = 2;}
    });
  }
}
