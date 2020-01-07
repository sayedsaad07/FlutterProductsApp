// import 'package:flutter/cupertino.dart';
import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';

Future<void> onHandRefresh(GlobalKey<AsyncLoaderState> asyncLoaderState) async {
    await asyncLoaderState.currentState.reloadState();
    return;
  }

class NoConnectionWidget extends StatelessWidget {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState;

  NoConnectionWidget(this._asyncLoaderState);

  @override
  Widget build(BuildContext context) {
    return getNoConnectionWidget();
  }

  Widget getNoConnectionWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 60.0,
          child: new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/no-wifi.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        new Text("No Internet Connection"),
        new FlatButton(
            color: Colors.red,
            child: new Text(
              "Retry",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => _asyncLoaderState.currentState.reloadState())
      ],
    );
  }
}
