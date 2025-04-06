
// Create a CartProvider to manage cart state using ChangeNotifier
// Create a new file named 'cart_provider.dart'

import 'package:flutter/material.dart';
import 'product_model.dart';

class CartItem {
  final Product product;
  int quantity;
  
  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  
  Map<String, CartItem> get items {
    return {..._items};
  }
  
  int get itemCount {
    return _items.length;
  }
  
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }
  
  void addItem(Product product, {int quantity = 1}) {
    if (_items.containsKey(product.id)) {
      // Increase quantity
      _items.update(
        product.id,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity + quantity,
        ),
      );
    } else {
      // Add new item
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          product: product,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }
  
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
  
  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
    } else if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: quantity,
        ),
      );
      notifyListeners();
    }
  }
  
  void clear() {
    _items.clear();
    notifyListeners();
  }
}