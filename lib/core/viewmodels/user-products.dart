import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:starter_app/core/models/common-constants.dart';

class UserProducts {
  addlikeProduct(productid, userid, usertoken) async {
    var data = {'productId': productid};
    await http.post(
        '$baseUrl/Likedproducts/$userid/products/$productid.json?auth=$usertoken',
        body: json.encode(data));
  }

  removelikeProduct(productid, userid, usertoken) async {
    await http.delete(
        '$baseUrl/Likedproducts/$userid/products/$productid.json?auth=$usertoken');
  }

  getLikedProducts(userid, usertoken) async {
    List<String> _productIds = [];
    var response = await http
        .get('$baseUrl/Likedproducts/$userid/products.json?auth=$usertoken');
    Map<String, dynamic> productsListData = json.decode(response.body);
    if (productsListData != null) {
      productsListData.forEach((String productId, dynamic productData) {
        _productIds.add(productId);
      });
    }
    return _productIds;
  }
}
