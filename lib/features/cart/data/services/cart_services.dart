import 'package:cart_app/core/services/api_services.dart';
import 'package:cart_app/core/utils/urls.dart';
import 'package:dio/dio.dart';

class CartServices {
  

  // Fetch products
  Future<Response> getProducts() async {
    try {
      final Response response = await ApiService().getRequest(Urls.baseUrl+Urls.products);
      return response;
    } catch (e) {
      throw Exception('failed to fetch products: $e');
    }
  }

  //fetch product details
   Future<Response> getProductDetails({required String productId}) async {
    try {
      final Response response = await ApiService().getRequest('${Urls.baseUrl}${Urls.products}/$productId');
      return response;
    } catch (e) {
      throw Exception('failed to fetch product details: $e');
    }
  }
  //add cart
   Future<Response> addCart({required String productId}) async {
    try {
      final Response response = await ApiService().postRequest(Urls.baseUrl+Urls.cartadd,
        {
"productId":productId
      }) ;
      return response;
    } catch (e) {
      throw Exception('failed to add cart: $e');
    }
  }
  //delete cart item
   Future<Response> removeCart({required String productId}) async {
    try {
      final String endpoint = '${Urls.baseUrl}${Urls.cart}/$productId';
      final Response response = await ApiService().deleteRequest(endpoint
        ) ;
      return response;
    } catch (e) {
      throw Exception('failed to remove cart: $e');
    }
  }
  //view cart
   Future<Response> viewCart() async {
    try {
      final Response response = await ApiService().getRequest(Urls.baseUrl+Urls.cart) ;
      return response;
    } catch (e) {
      throw Exception('failed to fetch cart: $e');
    }
  }
}
