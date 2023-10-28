
import 'package:e_comerce_app_project/layout/cubit/states.dart';
import 'package:e_comerce_app_project/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../layout/cubit/cubit.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/styles/icon_broken.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();





  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is ProductAddingSuccess)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product added successfully!')),
          );
          _nameController.clear();
          _quantityController.clear();
          _priceController.clear();
          _categoryController.clear();
          _descriptionController.clear();
          AppCubit.get(context).imageFile = null;

        }
        else if (state is ProductAddingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add product: ${state.error}')),
          );
        }


      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        if (state is ProductAddingLoading)
        {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        else
        {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    designedFormField(
                      fontColor: AppCubit.get(context).isDark?Colors.white:Colors.black,
                      controller: _nameController,
                      type: TextInputType.text,
                      label: "Name address",
                      validator: (value){
                        if(value.isEmpty)
                        {
                          return "Name must not be empty";
                        }

                      },
                      prefixIcon: Icons.production_quantity_limits,

                    ),

                    const SizedBox(height: 15,),

                    designedFormField(
                      fontColor: AppCubit.get(context).isDark?Colors.white:Colors.black,
                      controller: _categoryController,
                      type: TextInputType.text,
                      label: "Category address",
                      validator: (value){
                        if(value.isEmpty)
                        {
                          return "Category must not be empty";
                        }

                      },
                      prefixIcon: IconBroken.Category,

                    ),

                    const SizedBox(height: 15,),

                    designedFormField(
                      fontColor: AppCubit.get(context).isDark?Colors.white:Colors.black,
                      controller: _priceController,
                      type: TextInputType.number,
                      label: "Price address",
                      validator: (value){
                        if(value.isEmpty)
                        {
                          return "Price must not be empty";
                        }

                      },
                      prefixIcon:   Icons.price_change_outlined,

                    ),

                    const SizedBox(height: 15,),


                    designedFormField(
                      fontColor: AppCubit.get(context).isDark?Colors.white:Colors.black,
                      controller: _quantityController,
                      type: TextInputType.number,
                      label: "Quantity address",
                      validator: (value){
                        if(value.isEmpty)
                        {
                          return "Quantity must not be empty";
                        }

                      },
                      prefixIcon:   Icons.price_change_outlined,

                    ),

                    const SizedBox(height: 15,),

                    designedFormField(
                      fontColor: AppCubit.get(context).isDark?Colors.white:Colors.black,
                      controller: _descriptionController,
                      type: TextInputType.text,
                      label: "Description address",
                      validator: (value){
                        if(value.isEmpty)
                        {
                          return "Description must not be empty";
                        }

                      },
                      prefixIcon:   Icons.abc,

                    ),

                    const SizedBox(height: 16.0),


                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async
                        {
                          await cubit.selectImage();
                        },
                        child: const Text('Select Image'),
                      ),
                    ),
                    if (cubit.imageFile != null) ...[
                      const Center(child: SizedBox(height: 8.0)),
                      Image.file(cubit.imageFile!),
                    ],


                    const SizedBox(height: 40.0),



                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red
                        ),
                        child: const Text(
                          'Added Products',
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            {
                              cubit.addProduct(
                                  productModel: ProductModel(
                                      description: _descriptionController.text,
                                      price: double.parse(_priceController.text),
                                      category: _categoryController.text,
                                      quantity: int.parse(_quantityController.text),
                                      title: _nameController.text,
                                      image: cubit.imageFile!.path
                                  ));

                              print('Add One Doc');
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
          );
        }
      },
    );
  }


  @override
  void dispose() {

    super.dispose();
  }



}

