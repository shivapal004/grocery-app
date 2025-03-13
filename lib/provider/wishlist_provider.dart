import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/wishlist_model.dart';

import '../models/cart_model.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getCartItems {
    return _wishlistItems;
  }

  void removeOneItem(String productId) {
    _wishlistItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
