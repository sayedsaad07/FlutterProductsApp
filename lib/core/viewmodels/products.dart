import 'dart:convert';
import 'dart:ffi';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_app/core/models/product.dart';
import 'package:starter_app/core/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:starter_app/core/viewmodels/local-settings.dart';

import '../../config.dart';

class UserModel extends Model {
  User _authenticatedUser;
  bool _isLoggedin = false;
  final String _authSigninWithCustomTokenUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?$appKey";
  final String _authSignupUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?$appKey";
  final String _authSigninWithEmailUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?$appKey";

  bool get isLoggedin {
    return _authenticatedUser != null;
  }

  Future<bool> autoAuthenticateUser() async {
    _authenticatedUser = await getAuthenticatedUserInfo();
    if (_authenticatedUser == null) return false;
    return true;
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    Map<String, dynamic> authdata = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    var response = await http.post(_authSignupUrl,
        body: json.encode(authdata),
        headers: {'Content-Type': 'application/json'});
    if (response.body != null) {
      var responseData = json.decode(response.body);

      if (responseData.containsKey('idToken') == false) {
        if (responseData['error']['message'] == "EMAIL_EXISTS") {
          return {
            'success': false,
            'error': "The email address is already in use by another account."
          };
        } else if (responseData['error']['message'] ==
            "OPERATION_NOT_ALLOWED") {
          return {
            'success': false,
            'error': "Password sign-in is disabled for this project."
          };
        } else if (responseData['error']['message'] ==
            "TOO_MANY_ATTEMPTS_TRY_LATER") {
          return {
            'success': false,
            'error':
                "We have blocked all requests from this device due to unusual activity. Try again later."
          };
        }
      }
      _authenticatedUser = User(
          email: email,
          id: responseData['localId'],
          idToken: responseData['idToken']);
      await setAuthenticatedUserInfo(_authenticatedUser.id,
          _authenticatedUser.email, _authenticatedUser.idToken);
      return {'success': true, 'error': ""};
    }
    return {'success': false, 'error': "Unable to Signup"};
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> authdata = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    var response = await http.post(_authSigninWithEmailUrl,
        body: json.encode(authdata),
        headers: {'Content-Type': 'application/json'});
    if (response.body != null) {
      var responseData = json.decode(response.body);

      if (responseData.containsKey('idToken') == false) {
        if (responseData['error']['message'] == "EMAIL_NOT_FOUND") {
          return {
            'success': false,
            'error':
                "There is no user record corresponding to this identifier. The user may have been deleted."
          };
        } else if (responseData['error']['message'] == "INVALID_PASSWORD") {
          return {
            'success': false,
            'error':
                "The password is invalid or the user does not have a password."
          };
        } else if (responseData['error']['message'] == "USER_DISABLED") {
          return {
            'success': false,
            'error': "The user account has been disabled by an administrator."
          };
        }
      }
      _authenticatedUser = User(
          email: email,
          id: responseData['localId'],
          idToken: responseData['idToken']);
      
      await setAuthenticatedUserInfo(_authenticatedUser.id,
          _authenticatedUser.email, _authenticatedUser.idToken);
      return {'success': true, 'error': ""};
    }
    return {'success': false, 'error': "Unable to Signup"};
  }
}

class ProductsModel extends UserModel {
  String _baseUrl = "https://connectutopia.firebaseio.com";
  var _networkhomeofficeImage =
      "https://tr1.cbsistatic.com/hub/i/2017/11/22/42deea0f-4f4b-44c6-a2dc-c855499ea92e/unlikely4.jpg";
  bool _displayFavoriteOnly = false;
  List<Product> _products = [];
  int _selectedProductIndex;

  List<Product> get allProducts {
    return List.from(_products);
  }

  int get currentProductIndex {
    return _selectedProductIndex;
  }

  Future<List<Product>> fetchProducts() async {
    var response = await http
        .get('$_baseUrl/products.json?auth=${_authenticatedUser.idToken}');
    Map<String, dynamic> productsListData = json.decode(response.body);
    this._products.clear();

    //exit if response body is empty
    if (productsListData == null) return this._products;

    productsListData.forEach((String productId, dynamic productData) {
      Product newProduct = new Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          image: productData['image'],
          price: productData['price'],
          userid: productData['userid'],
          username: productData['username']);
      this._products.add(newProduct);
    });
    notifyListeners();
    return this._products;
  }

  //add new product
  Future<void> addProduct(
      String title, String description, String image, double price) async {
    image = _networkhomeofficeImage;
    Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'username': _authenticatedUser.email,
      'userid': _authenticatedUser.id,
    };
    var response = await http.post(
        '$_baseUrl/products.json?auth=${_authenticatedUser.idToken}',
        body: json.encode(productData));
    // if(response.statusCode != HttpStatus.notFound){}
    Map<String, dynamic> data = json.decode(response.body);
    final Product newProduct = new Product(
        id: data['name'],
        title: title,
        description: description,
        price: price,
        image: image,
        username: _authenticatedUser.email,
        userid: _authenticatedUser.id,
        isFavorite: false);
    _products.add(newProduct);
    _selectedProductIndex = null;
    notifyListeners();
  }

  //update existing product
  Future<void> updateProduct(
      String title, String description, String image, double price) async {
    image = _networkhomeofficeImage;
    Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'username': _products[_selectedProductIndex].username,
      'userid': _products[_selectedProductIndex].userid,
    };
    var _productId = _products[_selectedProductIndex].id;

    await http.put(
        '$_baseUrl/products/$_productId.json?auth=${_authenticatedUser.idToken}',
        body: json.encode(productData));
    final Product newProduct = new Product(
        id: _products[_selectedProductIndex].id,
        title: title,
        description: description,
        price: price,
        image: image,
        username: _products[_selectedProductIndex].username,
        userid: _products[_selectedProductIndex].userid,
        isFavorite: false);
    _products[_selectedProductIndex] = newProduct;
    _selectedProductIndex = null;
    // notifyListeners();
  }

  bool get isFavoriteSelectedProduct {
    if (_selectedProductIndex == null) return false;
    return _products[_selectedProductIndex].isFavorite;
  }

  bool get displayFavoriteOnly {
    return _displayFavoriteOnly;
  }

  List<Product> displayProducts() {
    if (_displayFavoriteOnly == true) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  //delete product
  Future<void> deleteProduct() async {
    var _productId = _products[_selectedProductIndex].id;
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;

    await http.delete(
        '$_baseUrl/products/$_productId.json?auth=${_authenticatedUser.idToken}');

    // notifyListeners();
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
    this.notifyListeners();
  }

  void toggleProductFavorite(int productIndex) {
    int actualindex = _getProductIndex(productIndex);
    _selectedProductIndex = actualindex;
    if (_selectedProductIndex != null) {
      final bool isCurrentFavorite =
          _products[_selectedProductIndex].isFavorite;
      bool newFavoriteStatus = !isCurrentFavorite;
      final Product newProduct = Product(
          id: _products[_selectedProductIndex].id,
          title: _products[_selectedProductIndex].title,
          description: _products[_selectedProductIndex].description,
          price: _products[_selectedProductIndex].price,
          image: _products[_selectedProductIndex].image,
          username: _products[_selectedProductIndex].username,
          userid: _products[_selectedProductIndex].userid,
          isFavorite: newFavoriteStatus);
      _products[_selectedProductIndex] = newProduct;
      _selectedProductIndex = null;
      this.notifyListeners();
    }
  }

  void toggleDisplayFavoriteMode() {
    this._displayFavoriteOnly = !this._displayFavoriteOnly;
    this.notifyListeners();
  }

  int _getProductIndex(int productIndex) {
    var product = this.displayProducts()[productIndex];
    return this._products.indexOf(product);
  }
}
