import 'package:flutter/material.dart';
import 'package:starter_app/widgets/products/product_card.dart';


class ProductListPage extends StatelessWidget {
  final Function deleteProduct;
  final List<Map<String, dynamic>> _products;
    ProductListPage(this._products , this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: _products.length,
      );
  }

    Widget _buildProductItem(BuildContext context, int index) {
    return ProductCard(_products[index], index);
  }
}
