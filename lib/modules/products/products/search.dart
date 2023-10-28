// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, missing_required_param, sized_box_for_whitespace, prefer_const_constructors, non_constant_identifier_names

import 'package:e_comerce_app_project/layout/cubit/cubit.dart';
import 'package:e_comerce_app_project/layout/cubit/states.dart';
import 'package:e_comerce_app_project/model/product_model.dart';
import 'package:e_comerce_app_project/modules/products/products/update_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';




class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                      focusNode: FocusNode(),
                      controller: _searchController,
                      keyboardType: TextInputType.text,
                      onChanged: (val)
                      {
                         val = _searchController.text;
                        AppCubit.get(context).searchProductsByName(nameProduct: val);
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter Text to get Search';
                        }
                        return null;
                      },
                      onFieldSubmitted: (text) {
                        AppCubit.get(context).searchProductsByName(nameProduct: text);
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (state is SearchLoadingStates) LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child:  BlocConsumer<AppCubit, AppStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is SearchLoadingStates) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is SearchSuccessStates) {
                            final List<ProductModel> products = state.products;
                            return ListView.separated(
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final ProductModel product = products[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: SizedBox(
                                            height: 140,
                                            child:  Placeholder(child: Image.network(product.image!, fit: BoxFit.fill)),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 20,),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 8),
                                              child: Text(product.title, style: TextStyle(fontSize: 18),),
                                            ),
                                            Text('Price: ${product.price.toStringAsFixed(2)} \$'),
                                            Text('Quantity: ${product.quantity.toInt()} '),
                                            Text('category: ${product.category}'),
                                            Text(
                                              'description: ${product.description}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                            Row(
                                              children: [

                                                SizedBox(
                                                  width: 90 ,
                                                  child: ElevatedButton(
                                                      onPressed: ()
                                                      {
                                                        navigateTo(context, UpdateProduct(product: product));
                                                      },
                                                      child:  Text('Update'),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: SizedBox(
                                                    width: 90 ,
                                                    child: ElevatedButton(
                                                        onPressed: ()
                                                        {
                                                          AppCubit.get(context).deleteProduct(product.id!);
                                                          if(state is DeleteSuccessStates)
                                                            {
                                                              showToast(state: ToastStates.SUCCESS);
                                                            }
                                                          if(state is DeleteErrorStates)
                                                            {
                                                              showToast(state: ToastStates.ERROR);
                                                            }
                                                        },
                                                        child:  Text('Delete'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                              },

                              separatorBuilder:(context, index)=> SizedBox(height: 20,),
                            );
                          } else if (state is SearchErrorStates) {
                            return Center(
                              child: Text('Error occurred while searching for products.'),
                            );
                          } else {
                            AppCubit.get(context).searchProductsByName(nameProduct: _searchController.text);
                            return Container();
                          }
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }



}
