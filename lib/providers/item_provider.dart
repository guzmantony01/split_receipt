import 'package:flutter/material.dart';
import 'package:split_receipt/classes/classes.dart';


class ItemProvider extends ChangeNotifier {
  final List<Item> _item = [
    Item(0, "", 0.00, ""),
  ];

  void addItem({required int newItemID, required String newItemName, required double newItemCost, required String newProfileHolder}) {
    _item.add(Item(newItemID, newItemName, newItemCost, newProfileHolder));
  }
  
  void updateItemName({required int updatingItemID, required String updatingItemName}) {
    _item[updatingItemID].itemName = updatingItemName;
  }

  void updateItemCost({required int updatingItemID, required double updatingItemCost}) {
    _item[updatingItemID].itemCost = updatingItemCost;
  }

  void updateItemHolder({required int updatingItemID, required String updatingProfileHolder}) {
    _item[updatingItemID].profileHolder = updatingProfileHolder;
  }

  void removeItem({required int inputItemID}) {
    _item.removeAt(inputItemID);
  }

  void cleanUpItems() {
    for(int i = 0; i < _item.length; i++) {
      if(_item[i].itemName.isEmpty) {
        _item.removeAt(i);
        i -= 1;
      }
    }
  }

  int countInventory({required String inputProfileName}) {
    int inventoryCounter = 0;
    for(int i = 0; i < _item.length; i++) {
      if(_item[i].profileHolder == inputProfileName) {
        inventoryCounter++;
      }
    }
    return inventoryCounter;
  }

  String populateItemName({required String inputProfileName, required int index}) {
    int runningCount = 0;
    for(int i = 0; i < _item.length; i++) {
      if(_item[i].profileHolder == inputProfileName) {
        if(runningCount == index) {
          return _item[i].itemName;
        } else {
          runningCount++;
        }
      }
    }
    return "";
  }

  double populateItemCost({required String inputProfileName, required int index}) {
    int runningCount = 0;
    for(int i = 0; i < _item.length; i++) {
      if(_item[i].profileHolder == inputProfileName) {
        if(runningCount == index) {
          return _item[i].itemCost;
        } else {
          runningCount++;
        }
      }
    }
    return 0.00;
  }

  double calculateProfileTotalCost({required String inputProfileName}) {
    double runningCost = 0.00;
    for(int i = 0; i < _item.length; i++) {
      if(_item[i].profileHolder == inputProfileName) {
        runningCost += _item[i].itemCost;
      }
    }
    return runningCost;
  }

  double calculateTotalCost() {
    double runningCost = 0.00;
    for(int i = 0; i < _item.length; i++) {
      runningCost += _item[i].itemCost;
    }
    return runningCost;
  }

  List<Item> get getItem {
    return _item;
  }

}