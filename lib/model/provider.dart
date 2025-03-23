import 'package:flutter/material.dart';

import 'package:split_receipt/model/classes.dart';

class ReceiptProvider with ChangeNotifier {
  final List<Receipt> _receipts = [];

  List<Receipt> get receipts => _receipts;

  // Create a new receipt or get an existing one by ID
  Receipt getReceiptById(int id) {
    if (_receipts.isEmpty) {
      throw StateError('No receipts available');
    }
    return _receipts.firstWhere((receipt) => receipt.id == id, orElse: () {
      throw StateError('Receipt with id $id not found');
    });
  }

  // Renumber Receipt IDs
  void cleanUpReceipts() {
    int receiptsLength = _receipts.length;
    for (int receiptIndex = 0; receiptIndex < receiptsLength; receiptIndex++) {
      _receipts[receiptIndex].id = receiptIndex;
    }
  }

  // Add a new receipt
  void addReceipt(Receipt receipt) {
    _receipts.add(receipt);
  }

  // Add a profile to a specific receipt
  void addProfile(int receiptId, Profile profile) {
    final receipt = getReceiptById(receiptId);
    receipt.profiles.add(profile);
  }

  // Delete a profile from a receipt
  void deleteProfile(int receiptId, int profileIndex) {
    final receipt = getReceiptById(receiptId);
    receipt.profiles.removeAt(profileIndex);
  }

  // Add a profile to a specific receipt
  void addItem(int receiptId, Item item) {
    final receipt = getReceiptById(receiptId);
    receipt.items.add(item);
  }

  // Delete a profile from a receipt
  void deleteItem(int receiptId, int itemIndex) {
    final receipt = getReceiptById(receiptId);
    receipt.items.removeAt(itemIndex);
  }

  // Update an existing profile's name
  void updateProfileName(int receiptId, int profileIndex, String newName) {
    final receipt = getReceiptById(receiptId);
    receipt.profiles[profileIndex].name = newName;
  }

  // Update the fees (tax and tip) for a specific receipt
  void updateFees(int receiptId, double tax, double tip) {
    final receipt = getReceiptById(receiptId);
    receipt.fees = Fees(tax: tax, tip: tip);
  }
}
