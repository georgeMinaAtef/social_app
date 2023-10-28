import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
   const ProductDetails({super.key,required this.product});
  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product['image'] != null ?
            SizedBox(
              height: 260,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Center(child: Image.network(product['image'] , fit: BoxFit.fill,))),
            ) :
            const SizedBox(
                child: Placeholder(child: CircularProgressIndicator(),)
            ),

            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('Details For Product', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text('title:  ${product['title']} '),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text('price       :\t\t\t${product['price']} \$'),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text('quantity  :\t\t\t${product['quantity']} '),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text('category:  ${product['category']} '),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text('description:  ${product['description']} '),
            ),
          ],
        ),
      ),
    );
  }
}
