import 'package:flutter/material.dart';
import 'product_edit.dart';
import 'product_list.dart';

class ProductsAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Text("Chose"),
                ),
                ListTile(
                  leading: Icon(Icons.shop),
                  title: Text("Allo Products"),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/");
                  },
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Easy Start APp '),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.create),
                  text: "Add Product",
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: "My Products",
                ),
              ],
            ),
          ),
          body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: TabBarView(
                children: <Widget>[
                  ProductEditPage(),
                  ProductListPage()
                ],
              ))),
    );
  }
}
