//Add this package to debug UI rendering issues
// import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starter_app/core/viewmodels/products.dart';
import 'package:starter_app/pages/auth.dart';
import 'pages/product.dart';
import 'pages/products.dart';
import 'pages/products_admin.dart';

main(List<String> args) {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
        theme: ThemeData(
            accentColor: Colors.deepPurple,
            primarySwatch: Colors.indigo,
            brightness: Brightness.light,
            buttonColor: Colors.deepPurple),
        // home: AuthPage(), //because we have a default route "/"
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
            case '/auth':
              return MaterialPageRoute(builder: (_) => AuthPage());
            case '/home':
              return MaterialPageRoute(builder: (_) => ProductsPage());
            case '/admin':
              return MaterialPageRoute(builder: (_) => ProductsAdminPage());
            case '/product':
            default:
              print('route name is $settings.name');
              final List<String> pathElements = settings.name.split('/');
              // if (pathElements[0] != '') return null;
              if (pathElements[0] == '' && pathElements[1] == 'product') {
                final int productIndex = int.parse(pathElements[2]);
                return MaterialPageRoute<bool>(
                    builder: (BuildContext context) =>
                        ProductPage(productIndex));
              }
              return MaterialPageRoute(
                  builder: (BuildContext context) => ProductsPage());
          }
        });
    return ScopedModel<ProductsModel>(
        model: new ProductsModel(),
        child: ScopedModel<UserModel>(model: UserModel(), child: materialApp));
  }
}
