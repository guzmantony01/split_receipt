import 'package:flutter/material.dart';
import 'package:split_receipt/classes/classes.dart';


class ItemProvider extends ChangeNotifier {
  final List<Item> _item = [
    Item(0, "", 0.00, 99),
  ];

  void addItem({required int newItemID, required String newItemName, required double newItemCost, required int newitemHolderID}) {
    _item.add(Item(newItemID, newItemName, newItemCost, newitemHolderID));
  }
  
  void updateItemName({required int updatingItemID, required String updatingItemName}) {
    _item[updatingItemID].itemName = updatingItemName;
  }

  void updateItemCost({required int updatingItemID, required double updatingItemCost}) {
    _item[updatingItemID].itemCost = updatingItemCost;
  }

  void updateitemHolderID({required int updatingItemID, required int updatingitemHolderID}) {
    _item[updatingItemID].itemHolderID = updatingitemHolderID;
  }

  void removeItem({required int inputItemID}) {
    _item.removeAt(inputItemID);
  }

  int countInventory({required int inputNameID}) {
    int inventoryCounter = 0;
    for(int i = 0; i < _item.length; i++) {
      if(_item[i].itemHolderID == inputNameID) {
        inventoryCounter++;
      }
    }
    return inventoryCounter;
  }

  String populateItemName({required int inputNameID, required int totalCount, required int index}) {
    int runningCount = 0;
    for(int i = 0; i < _item.length; i++) {
      if(_item[i].itemHolderID == inputNameID) {
        if(runningCount == index) {
          return _item[i].itemName;
        } else {
          runningCount++;
        }
      }
    }
    return "";
  }

  double populateItemCost({required int inputNameID, required int totalCount, required int index}) {
    int runningCount = 0;
    for(int i = 0; i < _item.length; i++) {
      if(_item[i].itemHolderID == inputNameID) {
        if(runningCount == index) {
          return _item[i].itemCost;
        } else {
          runningCount++;
        }
      }
    }
    return 0.00;
  }

  double calculateTotalCost({required int inputNameID}) {
    double runningCost = 0.00;
    for(int i = 0; i < _item.length; i++) {
      if(_item[i].itemHolderID == inputNameID) {
        runningCost += _item[i].itemCost;
      }
    }
    return runningCost;
  }

  List<Item> get getItem {
    return _item;
  }

}