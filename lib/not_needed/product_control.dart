import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function addProduct;
  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        this.addProduct(
            {'title': 'Chocolate', 'image': 'assets/images/saad_india.jpg'});
        this.addProduct(
            {'title': 'Profile', 'image': 'assets/images/profile.png'});
      },
      child: Text('Add Product'),
    );
  }
}
