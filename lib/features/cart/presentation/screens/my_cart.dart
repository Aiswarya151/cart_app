import 'package:cart_app/core/router/router.dart';
import 'package:cart_app/features/authentication/viewmodel/auth_provider.dart';
import 'package:cart_app/features/cart/viewmodel/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState(){
    context.read<CartProvider>().viewCart();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Gap(10),
            Expanded(
              child: Consumer<CartProvider>(
                builder: (context,cartProvider,child) {
                  if(cartProvider.isLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  

                  return ListView.builder(
                   itemCount: cartProvider.cart?.items?.length ?? 0,

                    
                    itemBuilder: (context, index) {
                      final cartItem=cartProvider.cart!.items?[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            title: Text(cartItem?.name??""),
                            subtitle:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cartItem?.price??""),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Moves close icon up
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Centers items horizontally
                              children: [
                                GestureDetector(child: const Icon(Icons.close),
                                onTap: (){
cartProvider.removeCart(productId: cartItem!.productId??"", context: context);
                                },),
                  
                                // Removes extra padding around the button
                                // Prevents extra space
                  
                                Text(cartItem?.quantity?.toString() ?? '0'),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
