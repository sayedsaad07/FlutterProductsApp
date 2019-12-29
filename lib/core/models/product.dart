import 'package:flutter/material.dart';

class Product {
  final String title;
  final String description;
  final double price;
  final String image;
  final bool isFavorite;
  final String username;
  final String userid;
  
  Product(
      {@required this.title,
      @required this.description,
      @required this.price,
      @required this.image,
      @required this.username,
      @required this.userid,
      this.isFavorite = false
      });
}
