
import 'package:e_comerce_app_project/model/product_model.dart';
import 'package:flutter/material.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/icon_broken.dart';

class UpdateProduct extends StatelessWidget {
  UpdateProduct({super.key, required this.product});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  ProductModel product ;





  @override
  Widget build(BuildContext context) {
    _nameController.text = product.title;
    _descriptionController.text = product.description;
    _categoryController.text = product.category;
    _priceController.text = product.price.toString();
    _quantityController.text = product.quantity.toString();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Padding(
                  padding: EdgeInsets.only(bottom: 5,top: 15),
                  child: Text('product title ', style: TextStyle(fontSize: 20),),
                ),

                designedFormField(
                  fontColor: AppCubit.get(context).isDark?Colors.white:Colors.black,
                  controller: _nameController   ,
                  type: TextInputType.text,
                  // hint: product.title,
                  validator: (value){
                    if(value.isEmpty)
                    {
                      return 'Title must not null';
                    }

                  },
                  prefixIcon: Icons.production_quantity_limits,

                ),



                const Padding(
                  padding: EdgeInsets.only(bottom: 5,top: 15),
                  child: Text('product category ', style: TextStyle(fontSize: 20),),
                ),

                designedFormField(
                  fontColor: AppCubit.get(context).isDark?Colors.white:Colors.black,
                  controller: _categoryController,
                  // hint: product.category,
                  type: TextInputType.text,
                  validator: (value){
                    if(value.isEmpty)
                    {

                      return "Category must not be empty";
                    }

                  },
                  prefixIcon: IconBroken.Category,

                ),



                const Padding(
                  padding: EdgeInsets.only(bottom: 5,top: 15),
                  child: Text('product price ', style: TextStyle(fontSize: 20),),
                ),
                designedFormField(
                  fontColor: AppCubit.get(context).isDark?Colors.white:Colors.black,
                  controller: _priceController,
                  type: TextInputType.number,
                  // hint:product.price.toString(),
                  validator: (value){
                    if(value.isEmpty)
                    {
                      return 'Price must not null';
                    }

                  },
                  prefixIcon:   Icons.price_change_outlined,

                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 5,top: 15),
                  child: Text('product quantity ', style: TextStyle(fontSize: 20),),
                ),
                designedFormField(
                  fontColor: AppCubit.get(context).isDark?Colors.white:Colors.black,
                  controller: _quantityController,
                  type: TextInputType.number,
                  // hint: ' ${product.quantity.toString()}',
                  validator: (value){
                    if(value.isEmpty)
                    {
                      return "Quantity must not be empty";
                    }

                  },
                  prefixIcon:   Icons.price_change_outlined,

                ),

                const Padding(
                  padding: EdgeInsets.only(bottom: 5,top: 15),
                  child: Text('product description ', style: TextStyle(fontSize: 20),),
                ),
                designedFormField(
                  fontColor: AppCubit.get(context).isDark?Colors.white:Colors.black,
                  controller: _descriptionController,
                  type: TextInputType.text,
                  // hint: ' ${product.description}',
                  validator: (value){
                    if(value.isEmpty)
                    {
                      return "Description must not be empty";
                    }

                  },
                  prefixIcon:   Icons.abc,

                ),

                // const SizedBox(height: 16.0),
                //
                //
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () async
                //     {
                //       await AppCubit.get(context).selectImage();
                //     },
                //     child: const Text('Select Image'),
                //   ),
                // ),
                //
                // if (AppCubit.get(context).imageFile != null) ...[
                //   const Center(child: SizedBox(height: 8.0)),
                //   Image.file(AppCubit.get(context).imageFile!),
                // ],


                const SizedBox(height: 40.0),



                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red
                      ),
                      child: const Text(
                        'Update Products',
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          {

                            AppCubit.get(context).updateProduct(
                              title:_nameController.text,
                              category:_categoryController.text,
                              description:_descriptionController.text,
                                quantity: int.parse(_quantityController.text),
                                price: double.parse(_priceController.text) ,
                                id: product.id!
                            );

                            Navigator.of(context).pop();
                          }
                        }
                      }

                  ),
                ),

                const SizedBox(height: 16.0),


                // Expanded(
                //   child: _buildProductList(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
