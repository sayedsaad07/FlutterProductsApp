import 'package:flutter/material.dart';
import 'package:starter_app/pages/product_edit.dart';
import 'package:starter_app/widgets/products/product_card.dart';

class ProductListPage extends StatelessWidget {
  final Function deleteProduct;
  final Function updateProduct;
  final List<Map<String, dynamic>> _products;
  ProductListPage(this._products, this. updateProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: _products.length,
    );
  }

  Widget _buildProductItem(BuildContext context, int index) {
    // return ProductCard(_products[index], index);
    return ListTile(
      onTap: () {},
      leading: Image.asset(_products[index]['image']),
      title: Text(_products[index]['title']),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          _editProduct(context, _products[index], index );
        },
      ),
    );
  }

  void _editProduct(context, Map<String, dynamic> product, index) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ProductEditPage(updateProduct: updateProduct, product: product, productIndex: index );
    }));
  }
}
