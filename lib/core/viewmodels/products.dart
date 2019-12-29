import 'package:scoped_model/scoped_model.dart';
import 'package:starter_app/core/models/product.dart';
import 'package:starter_app/core/models/user.dart';

class UserModel extends Model {
  User _authenticatedUser;
  bool _isLoggedin = false;

  bool get isLoggedin {
    return _authenticatedUser != null;
  }

  void login(String email, String password) {
    _authenticatedUser =
        User(email: email, password: password, id: "thisissayedid");
  }
}

class ProductsModel extends UserModel {
  bool _displayFavoriteOnly = false;
  List<Product> _products = [];
  int _selectedProductIndex;

  List<Product> get allProducts {
    return List.from(_products);
  }

  int get currentProductIndex {
    return _selectedProductIndex;
  }

  //add new product
  void addProduct(
      String title, String description, String image, double price) {
    final Product newProduct = new Product(
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
  void updateProduct(
      String title, String description, String image, double price) {
    final Product newProduct = new Product(
        title: title,
        description: description,
        price: price,
        image: image,
        username: _products[_selectedProductIndex].username,
        userid: _products[_selectedProductIndex].userid,
        isFavorite: false);
    _products[_selectedProductIndex] = newProduct;
    _selectedProductIndex = null;
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
  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
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
