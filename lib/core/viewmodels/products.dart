import 'package:scoped_model/scoped_model.dart';
import 'package:starter_app/core/models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;
  bool _displayFavoriteOnly = false;

  List<Product> get products {
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
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

  // void addProduct(
  //     String title, String description, String image, double price) {
  //   _products.add(Product(
  //       title: _products[_selectedProductIndex].title,
  //       description: _products[_selectedProductIndex].description,
  //       price: _products[_selectedProductIndex].price,
  //       image: _products[_selectedProductIndex].image,
  //       isFavorite: false));
  //   _selectedProductIndex = null;
  // }
  //add new product
  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
  }

  //update existing product
  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
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
      this.updateProduct(Product(
          title: _products[_selectedProductIndex].title,
          description: _products[_selectedProductIndex].description,
          price: _products[_selectedProductIndex].price,
          image: _products[_selectedProductIndex].image,
          isFavorite: newFavoriteStatus));

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
