import 'package:flutter/material.dart';
import 'package:starter_app/models/product.dart';
import 'package:starter_app/widgets/products/products.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> products;

  ProductsPage(this.products);

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
          actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  
                ),
                color: Colors.red,
                onPressed: () {},
              )
          ],
        ),
        body: Products(this.products));
  }
}
