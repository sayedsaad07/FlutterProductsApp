import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:starter_app/core/models/product.dart';
import 'package:starter_app/core/viewmodels/products.dart';
import 'package:starter_app/widgets/products/product_card.dart';
import 'package:starter_app/widgets/ui_elements/no_connection.dart';

class Products extends StatefulWidget {
  final ProductsModel model;
  Products(this.model);

  @override
  State<StatefulWidget> createState() {
    return ProductsState();
  }
}

class ProductsState extends State<Products> {
  // @override
  // void initState() {
  //   widget.model.fetchProducts();
  //   super.initState();
  // }
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = new AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await widget.model.fetchProducts(),
      renderLoad: () => new CircularProgressIndicator(),
      renderError: ([error]) => new NoConnectionWidget(_asyncLoaderState),
      renderSuccess: ({data}) =>
          _buildProductList(widget.model.displayProducts()),
    );

    // return _buildProductList(widget.model.displayProducts());
    return RefreshIndicator(
        onRefresh: () => onHandRefresh(_asyncLoaderState),
        child: new Center(child: _asyncLoader));
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
