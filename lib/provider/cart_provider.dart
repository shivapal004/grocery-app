import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../consts/firebase_consts.dart';
import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> fetchCart() async {
    final User? user = auth.currentUser;
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    final length = userDoc.get('userCart').length;
    for (int i = 0; i < length; i++) {
      _cartItems.putIfAbsent(
          userDoc.get('userCart')[i]['productId'],
          () => CartModel(
              id: userDoc.get('userCart')[i]['cartId'],
              productId: userDoc.get('userCart')[i]['productId'],
              quantity: userDoc.get('userCart')[i]['quantity']));
    }
    notifyListeners();
  }

  void reduceQuantityByOne(String productId) {
    _cartItems.update(
        productId,
        (value) => CartModel(
            id: value.id, productId: productId, quantity: value.quantity - 1));
    notifyListeners();
  }

  void increaseQuantityByOne(String productId) {
    _cartItems.update(
        productId,
        (value) => CartModel(
            id: value.id, productId: productId, quantity: value.quantity + 1));
    notifyListeners();
  }

  Future<void> removeOneItem(
      {required String productId,
      required String cartId,
      required int quantity}) async {
    final User? user = auth.currentUser;
    await userCollection.doc(user!.uid).update({
      'userCart': FieldValue.arrayRemove([
        {'cartId': cartId, 'productId': productId, 'quantity': quantity}
      ])
    });
    _cartItems.remove(productId);
    await fetchCart();
    notifyListeners();
  }

  Future<void> clearOnlineCart() async {
    final User? user = auth.currentUser;
    await userCollection.doc(user!.uid).update({'userCart': []});
    _cartItems.clear();
    notifyListeners();
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
