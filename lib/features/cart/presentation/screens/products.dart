import 'package:cart_app/core/router/router.dart';
import 'package:cart_app/core/theme/app_colors.dart';
import 'package:cart_app/features/cart/presentation/widgets/product_shimmer.dart';
import 'package:cart_app/features/cart/viewmodel/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState(){
    final cartProvider = context.read<CartProvider>();
  cartProvider.fetchProducts();
  cartProvider.viewCart(); // fetches cartItems
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
          // style: TextStyle(
          //   fontSize: 24,
          //   fontWeight: FontWeight.bold,
          //   color: Colors.blue,
          // ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              context.pushNamed('cart');
              // Navigate to cart screen
            },
          ),
        ],
      ),
      body: 
           ProductList()
        
    );
  }
}

// Product Card Widget
class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return
    Consumer<CartProvider>(builder: (context,cartProvider,child){
      if(cartProvider.isLoading){
        return Center(child: ProductShimmer(),);
      }
      return
       GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 39),
        itemCount: cartProvider.products.length, // Adjust number of products
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two items per row
          crossAxisSpacing: 26,
          mainAxisSpacing: 33,
          childAspectRatio: 0.7, // Adjust height ratio
        ),
        itemBuilder: (context, index) {
          final product=cartProvider.products[index];
           return GestureDetector(
            onTap:() {context.pushNamed('productdetail',extra:product.id );},
             child: Container(
                   padding: const EdgeInsets.all(6),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(12),
                     border: Border.all(color: Colors.grey.shade300),
                     boxShadow: [
                       BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 1,
              offset: const Offset(0, 2),
                       ),
                     ],
                   ),
                   
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       // Placeholder for product image
                       Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
                       ),
                       const SizedBox(height: 8),
                       Center(
              child:  Text(
                product.name??"",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
                       ),
                       const SizedBox(height: 4),
                       Text(
              product.price??"",
              style: TextStyle(fontSize: 14, color: Colors.black),
                       ),
                       const SizedBox(height: 8),
                       SizedBox(
              width: double.infinity,
              height: 36,
              child: cartProvider.cart!.items!.any((item) => item.productId == product.id)
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
        cartProvider.addCart(productId: product.id ?? "", context: context);
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
           );
        },
      );
    
   
  });
  }
}
