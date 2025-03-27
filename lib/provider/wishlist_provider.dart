import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/wishlist_model.dart';

import '../consts/firebase_consts.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }

  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> fetchWishList() async {
    final User? user = auth.currentUser;
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    final length = userDoc.get('userWish').length;
    for (int i = 0; i < length; i++) {
      _wishlistItems.putIfAbsent(
          userDoc.get('userWish')[i]['productId'],
          () => WishlistModel(
                id: userDoc.get('userWish')[i]['wishlistId'],
                productId: userDoc.get('userWish')[i]['productId'],
              ));
    }
    notifyListeners();
  }

  Future<void> removeOneItem(
      {required String productId, required String wishlistIdId}) async {
    final User? user = auth.currentUser;
    await userCollection.doc(user!.uid).update({
      'userWish': FieldValue.arrayRemove([
        {
          'wishlistId': wishlistIdId,
          'productId': productId,
        }
      ])
    });
    _wishlistItems.remove(productId);
    await fetchWishList();
    notifyListeners();
  }

  Future<void> clearOnlineWishlist() async {
    final User? user = auth.currentUser;
    await userCollection.doc(user!.uid).update({'userWish': []});
    _wishlistItems.clear();
    notifyListeners();
  }

  void clearLocalWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
