import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:split_receipt/model/classes.dart';

import 'package:split_receipt/model/provider.dart';
import 'package:split_receipt/page_navigator.dart';

import 'package:split_receipt/model/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  Future<void> _getAllReceipts() async {
    final receiptProvider = context.read<ReceiptProvider>();

    List<Receipt>? retrievedReceipt = await DatabaseHelper.getAllReceipts();
    if (retrievedReceipt != null) {
      int receiptLength = retrievedReceipt.length;
      print('Retrieved Receipt Length is: $receiptLength');
      for (int receiptIndex = 0; receiptIndex < receiptLength; receiptIndex++) {
        receiptProvider.addReceipt(retrievedReceipt[receiptIndex]);
      }
    } else {
      print('No receipt found with the given ID.');
    }
    setState(() {});
  }

  void createFile(int receiptIndex) async {
    final receiptProvider = context.read<ReceiptProvider>();
    int receiptId = await DatabaseHelper.insertReceipt(receiptProvider.receipts[receiptIndex]);
    print('Inserted receipt with ID: $receiptId');
  }

  void deleteFile(int receiptIndex) async {
    await DatabaseHelper.deleteReceipt(receiptIndex);
    print('Deleted receipt with ID: $receiptIndex');
  }

  @override
  void initState() {
    super.initState();
    _getAllReceipts();
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

  Widget _buildTitle(BuildContext context) {
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
        child: Center(child: Text('Receipts'),),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
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
            _buildAllReceipt(context),
            _addSingleReceipt(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAllReceipt(BuildContext context) {
    final receiptList = context.read<ReceiptProvider>();
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      shrinkWrap: true,
      itemCount: receiptList.receipts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSingleReceipt(context, index),
                _deleteSingleReceipt(context, index),
              ],
            ),
            const Divider(height: 1, thickness: 1, color: Colors.black),
          ],
        );
      },
    );
  }

  Widget _buildSingleReceipt(BuildContext context, int index) {
    final receiptProvider = context.read<ReceiptProvider>();
    return GestureDetector(
      onTap:() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageNavigator(currentReceiptID: index), // Replace with your target page
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(receiptProvider.receipts[index].name),
        ],
      ),
    );
  }

  Widget _deleteSingleReceipt(BuildContext context, int index) {
    final receiptProvider = context.read<ReceiptProvider>();
    return GestureDetector(
      onTap: () {
        setState(() {
          receiptProvider.receipts.removeAt(index);
          receiptProvider.cleanUpReceipts();
          deleteFile(index);
        });
      },
      child: const Icon(
        Icons.delete,
        size: 30,
      )
    );
  }

  Widget _addSingleReceipt(BuildContext context) {
    final receiptProvider = context.read<ReceiptProvider>();
    int newReceiptIndex = receiptProvider.receipts.length;
    return GestureDetector(
      onTap: () {
        setState(() {
          receiptProvider.addReceipt(Receipt.create(id: newReceiptIndex, name: '', profiles: [], items: [], fees: Fees(tax: 0.00, tip: 0.00)));
          createFile(newReceiptIndex);
        });
      },
      child: const Icon(
        Icons.plus_one,
        size: 30,
      )
    );
  }
}