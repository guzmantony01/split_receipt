import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:split_receipt/model/provider.dart';
import 'package:split_receipt/page_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

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
        child: Center(child: Text('Reciepts'),),
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

  Widget _buildAllReceipt(BuildContext context,) {
    final provider = context.read<RecieptProvider>();
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      shrinkWrap: true,
      itemCount: provider.getReceipt.length,
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
          Text('Receipt: # $index'),
        ],
      ),
    );
  }

  Widget _deleteSingleReceipt(BuildContext context, int index) {
    final provider = context.read<RecieptProvider>();
    return GestureDetector(
      onTap: () {
        setState(() {
          provider.deleteReceipt(index);
        });
      },
      child: const Icon(
        Icons.delete,
        size: 30,
      )
    );
  }

  Widget _addSingleReceipt(BuildContext context) {
    final provider = context.read<RecieptProvider>();
    return GestureDetector(
      onTap: () {
        setState(() {
          provider.newReceipt();
        });
      },
      child: const Icon(
        Icons.plus_one,
        size: 30,
      )
    );
  }
}