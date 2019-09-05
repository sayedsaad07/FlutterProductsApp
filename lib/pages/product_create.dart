import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;
  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleValue;
  String descriptionValue;
  double priceValue;

  final Map<String, dynamic> _product = {
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
    return Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: paddingWidth / 2),
                children: <Widget>[
                  _buildTitleTextFormField(),
                  _buildDescriptionTextFormField(),
                  _buildPriceTextFormField(),
                  IconButton(
                    // child: Text("Submit"),
                    icon: Icon(
                      Icons.add,
                      size: 60.0,
                    ),
                    onPressed: () => _createProduct(),
                  )
                ])));
  }

  Widget _buildTitleTextFormField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Title'),
      validator: (String value) {
        if (value.isEmpty) {
          {
            return "Invalid Product Title";
          }
        }
      },
      onSaved: (String value) {
        _product['title'] = value;
      },
    );
  }

  TextFormField _buildDescriptionTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 4,
      validator: (String value) {
        if (value.isEmpty) {
          {
            return "Invalid Product description";
          }
        }
      },
      onSaved: (String value) {
        _product['description'] = value;
      },
    );
  }

  Widget _buildPriceTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Product Price'),
      validator: (String value) {
        if (value.isEmpty &&
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return "Invalid Price value";
        }
      },
      onSaved: (String value) {
        _product['price'] = double.parse(value);
      },
    );
  }

  void _createProduct() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    widget.addProduct(_product);
    Navigator.pushNamed(context, "/");
  }

  void _showModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Center(child: Text("Save Product"));
        });
  }
}
