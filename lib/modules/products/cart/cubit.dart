
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comerce_app_project/modules/products/cart/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/cart_item.dart';
import '../../../shared/components/components.dart';



class CartCubit extends Cubit<CartState> implements StateStreamable<CartState>{
  CartCubit() : super(CartState([], 0));


  void addItemToCart(CartItem item) {
    final updatedItems = List<CartItem>.from(state.items);

    // Check if the item already exists in the cart
    final existingIndex = updatedItems.indexWhere((cartItem) => cartItem.id == item.id);

    // If the item already exists, you can choose to update its quantity or ignore it
    if (existingIndex != -1) {
      final existingItem = updatedItems[existingIndex];
      // Update the existing item's quantity or perform other required actions
      // Example: existingItem.quantity += item.quantity;

      // Update the total price
      final totalPrice = calculateTotalPrice(updatedItems);
      emit(CartState(updatedItems, totalPrice));
      return;
    }

    // If the item is not found, add it to the cart
    updatedItems.add(item);

    // Update the total price
    final totalPrice = calculateTotalPrice(updatedItems);
    emit(CartState(updatedItems, totalPrice));
  }


  void clearCart() {
    final updatedItems = List<CartItem>.from(state.items);
    updatedItems.clear();
    emit(CartState(updatedItems,0));
  }

  void removeItemFromCart(CartItem item) {
      final updatedItems = List<CartItem>.from(state.items);
      updatedItems.remove(item);
      final totalPrice = calculateTotalPrice(updatedItems);
      emit(CartState(updatedItems, totalPrice));

  }

  void updateItemQuantity(CartItem item, int newQuantity) {
    final updatedItems = List<CartItem>.from(state.items);
    final index = updatedItems.indexOf(item);

    if (index != -1 && newQuantity <= item.allQuantity) {
      item.quantity = newQuantity;
      updatedItems[index] = item;

    }

    final totalPrice = calculateTotalPrice(updatedItems);

    emit(CartState(updatedItems, totalPrice));
  }



  double calculateTotalPrice(List<CartItem> items) {
    return items.fold(0, (total, product) => total + (product.price * product.quantity));
  }

  // double calculateTotalQuantity(List<CartItem> items) {
  //   return items.fold(0, (total, product) => total + product.quantity);
  // }




  void updateAllQuantities(List<int> quantities) async {
    try {
      final productIds = state.items.map((product) => product.id).toList();

      await Future.wait(productIds.map((productId) {
        final index = productIds.indexOf(productId);
        final quantity = quantities[index];

        return FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .update({'quantity': FieldValue.increment(-quantity)})
            .then((_) {
          showToast(
            state: ToastStates.SUCCESS,
            text: 'Update Product Successfully',
          );
        });
      }));
    } catch (e) {
      showToast(
        state: ToastStates.ERROR,
        text: 'Error when updating products: ${e.toString()}',
      );
    }
  }

}