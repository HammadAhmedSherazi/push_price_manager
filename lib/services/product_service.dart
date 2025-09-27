import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product_data_model.dart';

class ProductService {
  static List<RealProductDataModel> _products = [];
  static bool _isLoaded = false;

  // Load products from JSON file
  static Future<List<RealProductDataModel>> loadProducts() async {
    if (_isLoaded && _products.isNotEmpty) {
      return _products;
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/data/products.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      
      _products = jsonList.map((json) => RealProductDataModel.fromJson(json)).toList();
      _isLoaded = true;
      
      return _products;
    } catch (e) {
      // Error loading products: $e
      return [];
    }
  }

  // Get all products
  static Future<List<RealProductDataModel>> getAllProducts() async {
    return await loadProducts();
  }

  // Get products by category
  static Future<List<RealProductDataModel>> getProductsByCategory(String category) async {
    final products = await loadProducts();
    return products.where((product) => product.category?.toLowerCase() == category.toLowerCase()).toList();
  }

  // Get product by name
  static Future<RealProductDataModel?> getProductByName(String name) async {
    final products = await loadProducts();
    try {
      return products.firstWhere((product) => product.item.toLowerCase() == name.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  // Get best buy products (products with significant discount)
  static Future<List<RealProductDataModel>> getBestBuyProducts() async {
    final products = await loadProducts();
    return products.where((product) {
      final discount = ((product.regularPrice - product.bestBuyPrice) / product.regularPrice) * 100;
      return discount >= 30; // 30% or more discount
    }).toList();
  }

  // Get products expiring soon (within next 7 days)
  static Future<List<RealProductDataModel>> getProductsExpiringSoon() async {
    final products = await loadProducts();
    final now = DateTime.now();
    final sevenDaysFromNow = now.add(const Duration(days: 7));
    
    return products.where((product) {
      try {
        final bestByDate = DateTime.parse(product.bestByDate);
        return bestByDate.isBefore(sevenDaysFromNow) && bestByDate.isAfter(now);
      } catch (e) {
        return false;
      }
    }).toList();
  }

  // Convert to ProductSelectionDataModel for UI compatibility
  static Future<List<ProductSelectionDataModel>> getProductSelectionModels() async {
    final products = await loadProducts();
    return products.map((product) => product.toProductSelectionDataModel()).toList();
  }

  // Search products
  static Future<List<RealProductDataModel>> searchProducts(String query) async {
    if (query.isEmpty) return await getAllProducts();
    
    final products = await loadProducts();
    return products.where((product) {
      return product.item.toLowerCase().contains(query.toLowerCase()) ||
             product.category?.toLowerCase().contains(query.toLowerCase()) == true ||
             product.description?.toLowerCase().contains(query.toLowerCase()) == true;
    }).toList();
  }

  // Get categories
  static Future<List<String>> getCategories() async {
    final products = await loadProducts();
    final categories = products.map((product) => product.category ?? 'Other').toSet().toList();
    categories.sort();
    return categories;
  }

  // Clear cached data (useful for testing or refreshing)
  static void clearCache() {
    _products.clear();
    _isLoaded = false;
  }
}
