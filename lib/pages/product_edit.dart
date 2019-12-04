import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:starter_app/core/models/product.dart';
import 'package:starter_app/core/viewmodels/products.dart';

class ProductEditPage extends StatefulWidget {
  final Product product;
  ProductEditPage({this.product});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formProduct = {
    'title': null,
    'description': null,
    'price': 0.00,
    'image': 'assets/images/saad_india.jpg'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double paddingWidth = deviceWidth - targetWidth;
    Widget editProductWidget = Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: paddingWidth / 2),
                children: <Widget>[
                  _buildTitleTextFormField(),
                  _buildDescriptionTextFormField(),
                  _buildPriceTextFormField(),
                  _buildSubmitButton()
                ])));

    if (widget.product == null) {
      return editProductWidget;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product "),
      ),
      body: editProductWidget,
    );
  }

  Widget _buildTitleTextFormField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      initialValue: widget.product == null ? '' : widget.product.title,
      validator: (String value) {
        if (value.isEmpty) {
          {
            return "Invalid Product Title";
          }
        }
      },
      onSaved: (String value) {
        _formProduct['title'] = value;
      },
    );
  }

  TextFormField _buildDescriptionTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 4,
      initialValue: widget.product == null ? '' : widget.product.description,
      validator: (String value) {
        if (value.isEmpty) {
          {
            return "Invalid Product description";
          }
        }
      },
      onSaved: (String value) {
        _formProduct['description'] = value;
      },
    );
  }

  Widget _buildPriceTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Product Price'),
      initialValue:
          widget.product == null ? '' : widget.product.price.toString(),
      validator: (String value) {
        if (value.isEmpty &&
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return "Invalid Price value";
        }
      },
      onSaved: (String value) {
        _formProduct['price'] = double.parse(value);
      },
    );
  }

  void _submitProduct(Function addProduct, Function updateProduct) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (widget.product == null) {
      //Add new product
      addProduct(Product(
          title: _formProduct['title'],
          description: _formProduct['description'],
          price: _formProduct['price'],
          image: _formProduct['image']));
    } else {
      //update existing product
      updateProduct(Product(
        title: _formProduct['title'],
        description: _formProduct['description'],
        price: _formProduct['price'],
        image: _formProduct['image']));
    }
    Navigator.pushNamed(context, "/");
  }

  // void _showModal(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Center(child: Text("Save Product"));
  //       });
  // }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return RaisedButton(
          child: Text("Save"),
          color: Colors.white,
          onPressed: () =>
              _submitProduct(model.addProduct, model.updateProduct),
        );
      },
    );
  }
}
