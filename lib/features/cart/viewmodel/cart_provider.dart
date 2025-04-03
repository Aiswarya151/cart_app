import 'dart:developer';


import 'package:cart_app/features/cart/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cart_app/features/cart/data/services/cart_services.dart';


class CartProvider extends ChangeNotifier {
  
  List<ProductModel> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _isLoading = true;
    
    notifyListeners();

    try {
      Response response = await CartServices().getProducts();
      if (response.statusCode == 200) {
        log("Api Response: ${response.data.toString()}");
        final List<dynamic> data= response.data as List<dynamic>;
        _products = data.map((product)=>ProductModel.fromJson(product)).toList();
        
      } 
    } catch (e) {
     log(e.toString());
    }
finally{
_isLoading = false;
    notifyListeners();
}



    
  }

 
}
