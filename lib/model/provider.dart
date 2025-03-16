import 'package:flutter/material.dart';

import 'package:split_receipt/model/classes.dart';

class RecieptProvider extends ChangeNotifier {
  List<Receipt> _receipt = List.empty(growable: true);

  /// Fees Functions
  Fees? getFees(int receiptID) {
    return _receipt[receiptID].fees;
  }

  /// AllItems Functions
  List<Item>? getAllItems(int receiptID) {
    return _receipt[receiptID].items;
  }

  void newItem(int receiptID) {
    if (_receipt[receiptID].items == null) {
      _receipt[receiptID].items = [];  // Initialize to an empty list if it's null
    }

    int index = _receipt[receiptID].items!.length; // ! is used to tell it will never be null.
    _receipt[receiptID].items?.add(Item((index + 1), null, null));
  }

  void deleteItem(int receiptID, int itemID) {
    _receipt[receiptID].items?.removeAt(itemID);
  }

  /// Profile Functions
  List<Profile>? getProfiles(int receiptID) {
    return _receipt[receiptID].profiles;
  }

  /// Profile Items Functions
  List<Item>? getItemsFromProfile(int receiptID, int profileID) {
    return _receipt[receiptID].profiles?[profileID].items;
  }

  /// Receipt Functions
  List<Receipt> get getReceipt {
    return _receipt;
  }

  void newReceipt() {
    int index = _receipt.length;
    _receipt.add(Receipt((index + 1), null, null, null));
  }

  void deleteReceipt(int receiptID) {
    _receipt.removeAt(receiptID);
  }
}