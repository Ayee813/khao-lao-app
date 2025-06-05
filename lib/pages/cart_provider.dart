import 'package:flutter/material.dart';
import 'product_model.dart';

class CartItem {
  final Product product;
  int quantity;
  double weightInKg; // Now properly initialized
  
  CartItem({
    required this.product,
    this.quantity = 1,
    required this.weightInKg, // Still required but with validation
  });
  
  // Format weight without decimal point if it's a whole number
  String get formattedWeight {
    if (weightInKg == weightInKg.round()) {
      return '${weightInKg.round()}kg'; // No decimal if it's a whole number
    } else {
      return '${weightInKg.toStringAsFixed(1)}kg'; // One decimal place otherwise
    }
  }
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
      // Calculate based on price per kg * weight in kg
      total += cartItem.product.price * cartItem.weightInKg;
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
          weightInKg: existingCartItem.weightInKg, // Maintain current weight
        ),
      );
    } else {
      // Parse initial weight from product.weight or default to 1.0
      double initialWeight = 1.0;
      try {
        // Try to parse the weight from the product's weight property (e.g., "5kg")
        String weightStr = product.weight.replaceAll(RegExp(r'[^0-9.]'), '');
        if (weightStr.isNotEmpty) {
          initialWeight = double.parse(weightStr);
        }
      } catch (e) {
        // If parsing fails, use default 1.0
        initialWeight = 1.0;
      }
      
      // Add new item with extracted or default weight
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          product: product,
          quantity: quantity,
          weightInKg: initialWeight, // Ensure it's never null
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
          weightInKg: existingCartItem.weightInKg, // Maintain current weight
        ),
      );
      notifyListeners();
    }
  }
  
  // Updated method to update weight with 1kg increment
  void updateWeight(String productId, double change) {
    if (_items.containsKey(productId)) {
      // Get current weight and add the change
      double currentWeight = _items[productId]!.weightInKg;
      double newWeight = currentWeight + change;
      
      // Ensure minimum weight of 0.5kg
      if (newWeight < 0.5) newWeight = 0.5;
      
      // Update weight in cart item
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity,
          weightInKg: newWeight,
        ),
      );
      
      // Format weight display (remove .0 if it's a whole number)
      String formattedWeight;
      if (newWeight == newWeight.round()) {
        formattedWeight = '${newWeight.round()}kg';
      } else {
        formattedWeight = '${newWeight.toStringAsFixed(1)}kg';
      }
      
      // Update the product with formatted weight
      Product updatedProduct = _items[productId]!.product.copyWithWeight(formattedWeight);
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          product: updatedProduct,
          quantity: existingCartItem.quantity,
          weightInKg: newWeight,
        ),
      );
      
      notifyListeners();
    }
  }
  
  // New method to set exact weight
  void setExactWeight(String productId, String weightInput) {
    if (_items.containsKey(productId)) {
      // Parse the input, handle validation
      double newWeight;
      try {
        // Convert input to double, defaulting to current weight if parsing fails
        newWeight = double.tryParse(weightInput) ?? _items[productId]!.weightInKg;
      } catch (e) {
        // If there's any other error, don't update
        return;
      }
      
      // Validate the weight is reasonable (minimum 0.5kg)
      if (newWeight < 0.5) newWeight = 0.5;
      
      // Update weight in cart item
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity,
          weightInKg: newWeight,
        ),
      );
      
      // Format weight display (remove .0 if it's a whole number)
      String formattedWeight;
      if (newWeight == newWeight.round()) {
        formattedWeight = '${newWeight.round()}kg';
      } else {
        formattedWeight = '${newWeight.toStringAsFixed(1)}kg';
      }
      
      // Update the product with formatted weight
      Product updatedProduct = _items[productId]!.product.copyWithWeight(formattedWeight);
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          product: updatedProduct,
          quantity: existingCartItem.quantity,
          weightInKg: newWeight,
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