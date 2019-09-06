import 'package:flutter/material.dart';
import 'package:starter_app/models/product.dart';
import 'package:starter_app/pages/product_edit.dart';
import 'package:starter_app/widgets/products/product_card.dart';

class ProductListPage extends StatelessWidget {
  final Function deleteProduct;
  final Function updateProduct;
  final List<Product> _products;
  ProductListPage(this._products, this.updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: _products.length,
    );
  }

  Widget _buildProductItem(BuildContext context, int index) {
    // return ProductCard(_products[index], index);
    var listTileWidget = ListTile(
      leading:
          CircleAvatar(backgroundImage: AssetImage(_products[index].image)),
      title: Text(_products[index].title),
      subtitle: Text('\$${_products[index].price.toString()}'),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          _editProduct(context, _products[index], index);
        },
      ),
    );
    return Dismissible(
        key: Key(_products[index].title),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          if (direction == DismissDirection.endToStart) {
            this.deleteProduct(index);
          }
        },
        child: Column(
          children: <Widget>[listTileWidget, Divider()],
        ));
  }

  void _editProduct(context, Product product, index) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ProductEditPage(
          updateProduct: updateProduct, product: product, productIndex: index);
    }));
  }
}
