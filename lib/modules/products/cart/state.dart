import 'package:e_comerce_app_project/model/cart_item.dart';

class CartState {
  final List<CartItem> items;
  final double totalPrice;

  CartState(this.items, this.totalPrice);
}