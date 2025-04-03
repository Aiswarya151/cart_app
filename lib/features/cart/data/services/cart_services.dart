import 'package:cart_app/core/services/api_services.dart';
import 'package:cart_app/core/utils/urls.dart';
import 'package:dio/dio.dart';

class CartServices {
  final Dio _dio=Dio();

  // Fetch products
  Future<Response> getProducts() async {
    try {
      final Response response = await ApiService().getRequest(Urls.baseUrl+Urls.products);
      return response;
    } catch (e) {
      throw Exception('failed to fetch products: $e');
    }
  }
  //view cart
   Future<Response> viewCart() async {
    try {
      final Response response = await _dio.get(Urls.baseUrl+Urls.cart) ;
      return response;
    } catch (e) {
      throw Exception('failed to fetch cart: $e');
    }
  }
}
