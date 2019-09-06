import 'package:flutter/material.dart';
import 'package:starter_app/models/product.dart';
import 'package:starter_app/widgets/products/product_card.dart';

class Products extends StatelessWidget {
  final List<Product> _products;
  Products(this._products);

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }

  //private methods
  Widget _buildProductList() {
    Widget productCard =
        Center(child: Text("No Products Available. Add new products."));
    if (_products.length > 0) {
      productCard = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: _products.length,
      );
    }
    return productCard;
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return ProductCard(_products[index], index);
  }
}

//Backup Using ListView
// @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: products
//           .map(
//             (element) => Card(
//               child: Column(
//                 children: <Widget>[
//                   Image.asset('assets/images/saad_india.jpg'),
//                   Text(element)
//                 ],
//               ),
//             ),
//           )
//           .toList(),
//     );
//   }

// // Navigation
// Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (BuildContext context) =>
//                   ProductsAdminPage()));
//     }
