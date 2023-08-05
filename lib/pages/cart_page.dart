import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 50),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.grey[800],
          ),
        ),
        body: Consumer<CartModel>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Let's order fresh items for you
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "My Cart",
                    style: GoogleFonts.notoSerif(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // list view of cart
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemCount: value.cartItems.length,
                      padding: EdgeInsets.all(12),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8)),
                            child: ListTile(
                               contentPadding: EdgeInsets.only(top: 8,left: 15,right: 15),
                              leading: Image.asset(
                                value.cartItems[index][2],
                                height: 45,
                              ),
                              title: Row(
                                children: [
                                  SizedBox(width: 7),
                                  Text(
                                    value.cartItems[index][0],
                                    style: const TextStyle(fontSize: 23),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  SizedBox(width: 7),
                                  Text(
                                    value.cartItems[index][1] + ' ₹',
                                    style: const TextStyle(fontSize: 16.5),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.close_rounded),
                                onPressed: () =>
                                    Provider.of<CartModel>(context, listen: false)
                                        .removeItemFromCart(index),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // total amount + pay now

                Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green,
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(color: Colors.green[200],fontSize: 21),
                            ),

                            const SizedBox(height: 3),
                            // total price
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Text(
                                '${value.calculateTotal()} ₹',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // pay now
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green.shade200,width: 3),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 28),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(
                                'Pay Now',
                                style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 7),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
