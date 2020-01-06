import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starter_app/core/viewmodels/products.dart';
import 'package:starter_app/widgets/products/products.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text("Chose"),
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Manage Products"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/admin");
                },
              ),
              ListTile(
                leading: Icon(Icons.lock_open),
                title: Text("login"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/auth");
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Easy Start'),
          actions: <Widget>[_favoriteActionButton()],
        ),
        body: ScopedModelDescendant<ProductsModel>(
            builder: (BuildContext context, Widget child, ProductsModel model) {
          return Products(model);
        }));
  }

  _favoriteActionButton() {
    return ScopedModelDescendant<ProductsModel>(
      builder: (context, child, ProductsModel model) {
        return IconButton(
          icon: Icon(
            model.displayFavoriteOnly ? Icons.favorite : Icons.favorite_border,
          ),
          color: Colors.red,
          onPressed: () {
            model.toggleDisplayFavoriteMode();
          },
        );
      },
    );
  }
}
