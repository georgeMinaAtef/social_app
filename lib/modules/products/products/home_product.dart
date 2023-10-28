
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comerce_app_project/modules/products/cart/cubit.dart';
import 'package:e_comerce_app_project/modules/products/products/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/cart_item.dart';
import '../../../shared/components/components.dart';

class HomeProducts extends StatelessWidget {
    const HomeProducts({super.key});


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data!.docs;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CarouselSlider(
                  items: products
                      .map((product) => SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(width: 1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Center(child: Image.network(product['image'], fit: BoxFit.fill)),
                      ),
                    ),
                  ))
                      .toList(),
                  options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true
                  )),


              const SizedBox(
                height: 30,
              ),

               const Padding(
                 padding: EdgeInsets.only(left: 30,),
                 child: Text('Products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
               ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 5.3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      final product = products[index].data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: ()
                        {
                          navigateTo(context, ProductDetails(product: product,));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            product['image'] != null ?
                            SizedBox(
                                height: 180,
                                width: 220,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Placeholder(
                                        child: Image.network(product['image'] , fit: BoxFit.fill,)
                                    )),
                            ) :
                            const SizedBox(
                                child: Placeholder(child: CircularProgressIndicator(),)
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text('title:  ${product['title']} '),
                            ),
                            Text('price       :\t\t\t${product['price']} \$'),
                            Text('quantity  :\t\t\t${product['quantity']} '),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: ()
                                {
                                  final cartItem = CartItem(
                                    id: products[index].id,
                                    title: product['title'],
                                    price: product['price'],
                                    image: product['image'],
                                    inCart: false,
                                    quantity:product['quantity'] == 0 ? 0: 1,
                                    allQuantity: product['quantity'],
                                  );
                                  context.read<CartCubit>().addItemToCart(cartItem);
                                   showToast(state: ToastStates.SUCCESS, text: 'Added to cart');
                                },


                                child:   const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Add Cart'),
                                    Icon(Icons.add_shopping_cart)
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      );


                    },
                  ),
                ),
              ),
            ],
          );
        }
        else if (snapshot.hasError)
        {
          showToast(state: ToastStates.ERROR);
          return const Text('Failed to fetch products');
        } else
        {

          return const Center(child: CircularProgressIndicator());
        }

      },
    );
  }



}



