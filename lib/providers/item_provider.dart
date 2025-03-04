import 'package:flutter/material.dart';

import 'package:split_receipt/classes/classes.dart';

class ItemProvider extends ChangeNotifier {
  final List<Items> _items = [
    Items(itemID: 0, itemName: "0", itemCost: 0.00),
    Items(itemID: 1, itemName: "1", itemCost: 1.00),
    Items(itemID: 2, itemName: "2", itemCost: 2.00),
    Items(itemID: 3, itemName: "3", itemCost: 3.00),
    Items(itemID: 4, itemName: "4", itemCost: 4.00),
    Items(itemID: 5, itemName: "5", itemCost: 5.00),
    Items(itemID: 6, itemName: "6", itemCost: 6.00),
    Items(itemID: 7, itemName: "7", itemCost: 7.00),
    Items(itemID: 8, itemName: "8", itemCost: 8.00),
    Items(itemID: 9, itemName: "9", itemCost: 9.00),
  ];

  void changeBillable({required int newItemID, required String newItemName, required double newItemCost}) {
    _items[newItemID].itemName = newItemName;
    _items[newItemID].itemCost = newItemCost;
  }
  
  List<Items> get getItems {
    return _items;
  }

}