import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/grocery_item_tile.dart';
import '../model/cart_model.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 50),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Icon(
              Icons.location_on,
              color: Colors.grey[700],
              size: 25,
            ),
          ),
          title: Text(
            'Pune, India',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[700],
            ),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Container(
                padding: EdgeInsets.only(top: 13,left: 16,right: 16,bottom: 19),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade800,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CartPage();
              },
            ),
          ),
          child: const Icon(Icons.shopping_bag,size: 30),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            // good morning bro
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('Good morning,',style: TextStyle(fontSize: 25),),
            ),

            const SizedBox(height: 4),

            // Let's order fresh items for you
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Let's order fresh items for you",
                style: GoogleFonts.notoSerif(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 17),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(),
            ),

            const SizedBox(height: 15),

            // categories -> horizontal listview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Fresh Items",
                style: GoogleFonts.notoSerif(
                  //fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),

            // recent orders -> show last 3
            Expanded(
              child: Consumer<CartModel>(
                builder: (context, value, child) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.shopItems.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.2,
                    ),
                    itemBuilder: (context, index) {
                      return GroceryItemTile(
                        itemName: value.shopItems[index][0],
                        itemPrice: value.shopItems[index][1],
                        imagePath: value.shopItems[index][2],
                        color: value.shopItems[index][3],
                        onPressed: () =>
                            Provider.of<CartModel>(context, listen: false)
                                .addItemToCart(index),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
