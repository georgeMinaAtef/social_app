import 'package:e_comerce_app_project/modules/products/cart/cart.dart';
import 'package:e_comerce_app_project/modules/products/products/home_product.dart';
import 'package:e_comerce_app_project/modules/products/products/search.dart';
import 'package:e_comerce_app_project/modules/settings/settings_screen.dart';
import 'package:e_comerce_app_project/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/products/products/add_product.dart';
import '../shared/styles/icon_broken.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
      var cubit = AppCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text(cubit.titles[cubit.currentIndex]),
          actions: [
            IconButton(
                onPressed: ()
                {
                  navigateTo(context, SearchScreen());
                },
                icon: const Icon(IconBroken.Search,)),
            IconButton(
                onPressed: ()
                {
                  navigateTo(context,  Cart());
                },
                icon: const Icon(Icons.add_shopping_cart,)),
          ],
        ),
        body: PageView(
          controller: cubit.pageController,
          onPageChanged: (index){
            cubit.changeIndexBottomNav(index);
          },
          scrollDirection: Axis.horizontal,
          children:    const [
           HomeProducts(),
            ProductScreen(),
           SettingsScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.pageController.animateToPage(index, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut,);
            cubit.changeIndexBottomNav(index);
          },
          items:  const [
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Category,
              ),
              label: 'Product',
            ),

            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Setting,
              ),
              label: 'Settings',
            ),

          ],
        ),
      );
    });
  }
}
