import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starter_app/core/models/product.dart';
import 'package:starter_app/core/viewmodels/products.dart';
import 'dart:async';

import 'package:starter_app/widgets/products/price_tag.dart';
import 'package:starter_app/widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final int _productIndex;
  ProductPage(this._productIndex);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Easy Start APP '),
          ),
          body: ScopedModelDescendant<ProductsModel>(
            builder: (context, Widget child, ProductsModel model) =>
              _showProductDetails(context , model.allProducts[_productIndex])
            
          )),
    );
  }

  //private methods
  Widget _showProductDetails(BuildContext context, Product product ) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.network(product.image),
        Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleDefault(product.title),
                SizedBox(
                  width: 8.0,
                ),
                PriceTag(product.price)
              ],
            )),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(4.0)),
          child: Text(
            product.description,
            style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(
              Icons.delete,
              size: 50.0,
            ),
            // child: Text("Delete"),
            onPressed: () => _onPressDeleteProduct(context),
          ),
        )
      ],
    );
  }
}

void _onPressDeleteProduct(BuildContext parentContext) {
  showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return _deleteAlertDialog(context);
      });
}

AlertDialog _deleteAlertDialog(BuildContext context) {
  return AlertDialog(
    title: Text("Are you sure?"),
    content: Text("Please make sure you want to delete"),
    actions: <Widget>[
      FlatButton(
        child: Text("Discard"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      FlatButton(
        child: Text("Delete"),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context, true);
        },
      )
    ],
  );
}
