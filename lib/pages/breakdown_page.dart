import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:split_receipt/model/provider.dart';


class BreakDownPage extends StatefulWidget {
  const BreakDownPage({required this.currentReceiptID, super.key});

  final int currentReceiptID;

  @override
  State<BreakDownPage> createState() {
    return _BreakDownPageState();
  }
}

class _BreakDownPageState extends State<BreakDownPage> {

  int countProfile() {
    final receiptProvider = context.read<ReceiptProvider>().receipts[widget.currentReceiptID];
    int count = 0;
    int itemLength = receiptProvider.items.length;
    for (int itemIndex = 0; itemIndex < itemLength; itemIndex++) {
      if (receiptProvider.items[itemIndex].buyer == '') {
        count = 1;
      }
    }
    return receiptProvider.profiles.length + count;
  }

  String returnProfileName(int profileIndex) {
    final receiptProvider = context.read<ReceiptProvider>().receipts[widget.currentReceiptID];
    int profileLength = receiptProvider.profiles.length;

    if (profileIndex < profileLength) {
      return receiptProvider.profiles[profileIndex].name;
    } else {
      return 'Unpaid Items';
    }
  }

  int countItemsPerProfile(int profileIndex) {
    final receiptProvider = context.read<ReceiptProvider>().receipts[widget.currentReceiptID];

    int count = 0;
    int itemLength = receiptProvider.items.length;
    int profileLength = receiptProvider.profiles.length;
    if (profileIndex < profileLength) {
      // Loop through Items
      for (int itemIndex = 0; itemIndex < itemLength; itemIndex++) {
        if (receiptProvider.profiles[profileIndex].name == receiptProvider.items[itemIndex].buyer) {
          count++;
        }
      }
    } else {
      // Loop through Items
      for (int itemIndex = 0; itemIndex < itemLength; itemIndex++) {
        if (receiptProvider.items[itemIndex].buyer == '') {
          count++;
        }
      }
    }
    return count;
  }

  int returnItemIndex(int profileIndex, int itemIndex) {
    final receiptProvider = context.read<ReceiptProvider>().receipts[widget.currentReceiptID];
    int itemLength = receiptProvider.items.length;
    int profileLength = receiptProvider.profiles.length;
    int count = -1;
    if (profileIndex < profileLength) {
      // Loop through Items
      for (int itemNo = 0; itemNo < itemLength; itemNo++) {
        if (receiptProvider.profiles[profileIndex].name == receiptProvider.items[itemNo].buyer) {
          count++;
        }
        if (count == itemIndex) {
          return itemNo;
        }
      }
    } else {
      // Loop through Items
      for (int itemNo = 0; itemNo < itemLength; itemNo++) {
        if (receiptProvider.items[itemNo].buyer == '') {
          count++;
        }
        if (count == itemIndex) {
          return itemNo;
        }
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
        child: Column(
          children: [
            _buildTitle(context),
            _buildList(context)
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {    // Build the top portion Header
    return const SizedBox(
      height: 50.0,
      child: Card(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          side: BorderSide(
            width: 2.0,
            color: Colors.black,
          ),
        ),
        child: Center(child: Text('Breakdown Page'),),
      ),
    );
  }

  Widget _buildList(BuildContext context) {   // SizedBox for the main list
    return SizedBox(
      child: Card(
        color: Colors.blue,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            width: 2.0,
            color: Colors.black,
          ),
        ),
        child: Column(
          children: [
            const Divider(height: 1, thickness: 1, color: Colors.black),
            _buildProfilesList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilesList(BuildContext context) {   // Build the list containing the profiles
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      shrinkWrap: true,
      itemCount: countProfile(),
      itemBuilder: (context, profileIndex) {
        return Column(
          children: [
            _buildPersonalBill(context, profileIndex),
            const Divider(height: 3, thickness: 3, color: Colors.black),
          ],
        );
      },
    );
  }

  Widget _buildPersonalBill(BuildContext context, int profileIndex) {   // Build the individual list per profile
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(returnProfileName(profileIndex)),
        _buildAllItemList(context, profileIndex),
        const Divider(height: 1, thickness: 1, color: Colors.black),
        _buildSubTotalCount(),
        _buildTaxTotalCount(),
        _buildTipTotalCount(),
        _buildTotalCount(),
      ],
    );
  }

  Widget _buildAllItemList(BuildContext context, int profileIndex) {    // Build the list all the items that belongs to the Profile
    return ListView.builder(
      shrinkWrap: true,
      itemCount: countItemsPerProfile(profileIndex),
      itemBuilder: (context, itemOfProfileIndex) {
        return Column(
          children: [
            _buildSingleItemList(context, profileIndex, itemOfProfileIndex),
          ],
        );
      },
    );
  }

  Widget _buildSingleItemList(BuildContext context, int profileIndex, int itemOfProfileIndex) {   // Build a single row of an item pertaining that profiles
    final receiptProvider = context.read<ReceiptProvider>().receipts[widget.currentReceiptID];
    int itemIndex = returnItemIndex(profileIndex, itemOfProfileIndex);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(receiptProvider.items[itemIndex].name),
        const Text('........'),
        Text(receiptProvider.items[itemIndex].cost.toStringAsFixed(2)),
      ],
    );
  }

  Widget _buildSubTotalCount() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('SubTotal'),
        Text('........'),
        Text('Cost'),
      ],
    );
  }

  Widget _buildTaxTotalCount() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Tax'),
        Text('........'),
        Text('Cost'),
      ],
    );
  }

  Widget _buildTipTotalCount() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Tip'),
        Text('........'),
        Text('Cost'),
      ],
    );
  }

  Widget _buildTotalCount() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total'),
        Text('........'),
        Text('Cost'),
      ],
    );
  }
}