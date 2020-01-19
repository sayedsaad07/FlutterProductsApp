import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:starter_app/core/models/product.dart';
import 'package:starter_app/core/viewmodels/products.dart';
import 'package:starter_app/pages/product_edit.dart';
import 'package:starter_app/widgets/ui_elements/popup-modal.dart';
import 'package:starter_app/widgets/ui_elements/no_connection.dart';

class ProductListPage extends StatefulWidget {
  final ProductsModel model;
  ProductListPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return new ProductListPageState();
  }
}

class ProductListPageState extends State<ProductListPage> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = new AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await widget.model.fetchProducts(),
      renderLoad: () => new CircularProgressIndicator(),
      renderError: ([error]) => new NoConnectionWidget(_asyncLoaderState),
      renderSuccess: ({data}) => _showProductList(widget.model),
    );

    // return _buildProductList(widget.model.displayProducts());
    return RefreshIndicator(
        onRefresh: () => onHandRefresh(_asyncLoaderState),
        child: new Center(child: _asyncLoader));
  }

  Widget _showProductList(ProductsModel model) {
    return model.allProducts == null || model.allProducts.length == 0
        ? new Center(
            child: Text("No products available to edit."),
          )
        : ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                _buildProductItem(context, index, model),
            itemCount: model.allProducts.length,
          );
  }

  Widget _buildProductItem(
      BuildContext context, int index, ProductsModel model) {
    // return ProductCard(model.products[index], index);
    var listTileWidget = ListTile(
      leading: CircleAvatar(
          backgroundImage: NetworkImage(model.allProducts[index].image)),
      title: Text(model.allProducts[index].title),
      subtitle: Text('\$${model.allProducts[index].price.toString()}'),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          model.selectProduct(index);
          if (model.canEditProduct(index) == false) {
            showSnackBar(context, "User is not authorized.");
            return;
          }
          _editProduct(context, model.allProducts[index], index);
        },
      ),
    );
    return Dismissible(
        key: Key(model.allProducts[index].id),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          if (direction == DismissDirection.endToStart &&
              model.canEditProduct(index) == true) {
            model.selectProduct(index);
            String productTitle = model.allProducts[index].title;
            model.deleteProduct();
            showSnackBar(context, "$productTitle removed.");
          }
          if (model.canEditProduct(index) == false) {
            showSnackBar(context, "User is not authorized.");
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
        product: product,
      );
    }));
  }
}
