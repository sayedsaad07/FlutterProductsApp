import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starter_app/core/models/product.dart';
import 'package:starter_app/core/viewmodels/products.dart';
import 'package:starter_app/widgets/products/product_card.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return _buildProductList(model.displayProducts());
    });
  }

  //private methods
  Widget _buildProductList(List<Product> products) {
    Widget productCard =
        Center(child: Text("No Products Available. Add new products."));
    if (products.length > 0) {
      productCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(products[index], index);
        },
        itemCount: products.length,
      );
    }
    return productCard;
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
