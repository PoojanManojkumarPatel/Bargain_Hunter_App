import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  // Controllers
  final TextEditingController searchController = TextEditingController();
  final TextEditingController storeController = TextEditingController();

  // State
  String searchTerm = '';
  String priceRange = '';
  String store = '';
  bool showFilters = false;

  // Setters
  void updateSearchTerm(String value) {
    searchTerm = value;
    notifyListeners();
  }

  void setPriceRange(String val) {
    priceRange = val;
    notifyListeners();
  }

  void setStore(String val) {
    store = val;
    notifyListeners();
  }

  void toggleFilters() {
    showFilters = !showFilters;
    notifyListeners();
  }

  void clear() {
    searchController.clear();
    storeController.clear();
    searchTerm = '';
    priceRange = '';
    store = '';
    showFilters = false;
    notifyListeners();
  }
}
