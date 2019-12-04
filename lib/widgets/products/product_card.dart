import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starter_app/core/models/product.dart';
import 'package:starter_app/core/viewmodels/products.dart';
import 'package:starter_app/widgets/products/price_tag.dart';
import 'package:starter_app/widgets/ui_elements/title_default.dart';

class ProductCard extends StatelessWidget {
  final Product _product;
  final int index;

  ProductCard(this._product, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(_product.image),
          Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TitleDefault(_product.title),
                  SizedBox(
                    width: 8.0,
                  ),
                  PriceTag(_product.price)
                ],
              )),
          Text(_product.description),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.info,
                  size: 50.0,
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () => _showProductDetails(context, index),
              ),
              _favoriteButton()
            ],
          )
        ],
      ),
    );
  }

  Widget _favoriteButton() {
    return ScopedModelDescendant<ProductsModel>(
      builder: (context, child, ProductsModel model) {
        return IconButton(
          icon: Icon(
            model.displayProducts()[index].isFavorite? Icons.favorite : Icons.favorite_border,
            size: 50.0,
          ),
          color: Colors.red,
          onPressed: () => model.toggleProductFavorite(index),
        );
      },
    );
  }

  _showProductDetails(BuildContext context, int productIndex) {
    Navigator.pushNamed<bool>(context, "/product/" + productIndex.toString())
        .then((bool value) {
      if (value) {
        // deleteProduct(productIndex);
      }
    });
    // Navigator.push<bool>(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) =>
    //             ProductPage(products[productIndex]))).then((bool value) {
    //   if (value) {
    //     deleteProduct(productIndex);
    //   }
    // });
  }
}
