import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starter_app/core/models/product.dart';
import 'package:starter_app/core/viewmodels/products.dart';
import 'package:starter_app/pages/product_edit.dart';
import 'package:starter_app/widgets/products/product_card.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (context, child, ProductsModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              _buildProductItem(context, index, model),
          itemCount: model.allProducts.length,
        );
      },
    );
  }

  Widget _buildProductItem(
      BuildContext context, int index, ProductsModel model) {
    // return ProductCard(model.products[index], index);
    var listTileWidget = ListTile(
      leading: CircleAvatar(
          backgroundImage: AssetImage(model.allProducts[index].image)),
      title: Text(model.allProducts[index].title),
      subtitle: Text('\$${model.allProducts[index].price.toString()}'),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          model.selectProduct(index);
          _editProduct(context, model.allProducts[index], index);
        },
      ),
    );
    return Dismissible(
        key: Key(model.allProducts[index].title),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          if (direction == DismissDirection.endToStart) {
            model.selectProduct(index);
            model.deleteProduct();
          }
        },
        child: Column(
          children: <Widget>[listTileWidget, Divider()],
        ));
  }

  void _editProduct(context, Product product, index) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ProductEditPage(product: product,);
    }));
  }
}
