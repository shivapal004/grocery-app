import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/viewed_model.dart';

class ViewedProvider with ChangeNotifier {
  final Map<String, ViewedModel> _viewedProdListItems = {};

  Map<String, ViewedModel> get getViewedProdListItems {
    return _viewedProdListItems;
  }

  void addProductToHistory({required String productId}) {
    _viewedProdListItems.putIfAbsent(
        productId,
            () => ViewedModel(
            id: DateTime.now().toString(),
            productId: productId,));
    notifyListeners();
  }

  void clearHistory(){
    _viewedProdListItems.clear();
    notifyListeners();
  }
}
