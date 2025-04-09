import 'package:cart_app/core/theme/app_colors.dart';

import 'package:cart_app/features/cart/viewmodel/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState(){
    context.read<CartProvider>().getProductDetails(productId: widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return Consumer<CartProvider>(
      builder: (context,cartProvider,child) {
        final  product=cartProvider.singleproduct;
        if(cartProvider.isLoading){
          return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
        }
        
        
        return Scaffold(
          
          appBar: AppBar(
            title: Text(product?.name ?? ""),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image placeholder
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product name and price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product?.name ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            product?.price ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      // Add to cart button
                          
                                SizedBox(
                                             // width: double.infinity,
                                             // height: 36,
                                             child: product?.alreadyInCart==true
                                 ? ElevatedButton(
                                     onPressed: () {
                                       context.pushNamed('cart');
                                     },
                                     style: ElevatedButton.styleFrom(
                                       backgroundColor: AppColors.primary,
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(12),
                                       ),
                                     ),
                                     child: const Text(
                                       "View in Cart",
                                       style: TextStyle(color: Colors.white),
                                     ),
                                   )
                                 : OutlinedButton(
                                     onPressed: () {
                                       cartProvider.addCart(productId: widget.productId , context: context);
                                     },
                                     style: OutlinedButton.styleFrom(
                                       side: const BorderSide(color: AppColors.primary),
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(12),
                                       ),
                                     ),
                                     child: const Text(
                                       "Add to cart",
                                       style: TextStyle(color: AppColors.primary),
                                     ),
                                   )
                               
                               ),
                             
                           
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
