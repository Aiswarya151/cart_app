import 'dart:developer';

import 'package:cart_app/core/shared_widgets/custom_snackbar.dart';
import 'package:cart_app/features/cart/data/model/cart_model.dart';
import 'package:cart_app/features/cart/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cart_app/features/cart/data/services/cart_services.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  ProductModel? _singleProduct;
  ProductModel? get singleproduct => _singleProduct;


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;

    try {
      Response response = await CartServices().getProducts();
      if (response.statusCode == 200) {
        log("Api Response: ${response.data.toString()}");
        final List<dynamic> data = response.data as List<dynamic>;
        _products =
            data.map((product) => ProductModel.fromJson(product)).toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getProductDetails({required String productId}) async{
_isLoading=true;
    try{
      Response response=await CartServices().getProductDetails(productId: productId);
      if (response.statusCode==200){
        log('Api response:${response.data.toString()}');
       
        _singleProduct=ProductModel.fromJson(response.data);

      }
    }
    catch(e){
      log(e.toString());
    }
    finally{
      _isLoading=false;
      notifyListeners();
    }

  }

  CartModel? _cart;

  CartModel? get cart => _cart;

  Future<void> viewCart() async {
    _isLoading = true;

    try {
      Response response = await CartServices().viewCart();
      if (response.statusCode == 200) {
        log("Api Response: ${response.data.toString()}");

        _cart = CartModel.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCart({
    required String productId,
    required BuildContext context,
  }) async {
    _isLoading = true;
    try {
      final response = await CartServices().addCart(productId: productId);

      if (response.statusCode == 200) {
        log(" Added to cart Successfully");
         customSnackbar(
            // ignore: use_build_context_synchronously
            context: context,
            message: "Item Added to cart Successfully",
            type: SnackbarType.success);
        await fetchProducts();
        await getProductDetails(productId: productId);
       
      }
    } catch (e) {
      log(" Error: $e");
      customSnackbar(
          // ignore: use_build_context_synchronously
          context: context,
          message: "Failed to add item",
          type: SnackbarType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeCart({
    required String productId,
    required BuildContext context,
  }) async {
    _isLoading = true;
    try {
      final response = await CartServices().removeCart(productId: productId);

      if (response.statusCode == 200) {
        log(" Removed cart item Successfully");
         customSnackbar(
            // ignore: use_build_context_synchronously
            context: context,
            message: "Item Removed from cart Successfully",
            type: SnackbarType.success);
        await viewCart();
        await fetchProducts();

       
      }
    } catch (e) {
      log(" Error: $e");
      customSnackbar(
          // ignore: use_build_context_synchronously
          context: context,
          message: "Failed to remove Item",
          type: SnackbarType.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
