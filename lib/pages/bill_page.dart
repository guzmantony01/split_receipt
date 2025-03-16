import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:split_receipt/model/provider.dart';

class BillPage extends StatefulWidget {
  const BillPage({required this.currentReceiptID, super.key});

  final int currentReceiptID;

  @override
  State<BillPage> createState() {
    return _BillPageState();
  }
}

class _BillPageState extends State<BillPage> {

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
        child: Center(child: Text('Add Items'),),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    final provider = context.read<RecieptProvider>();
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
            _buildAllItemList(context),
            _addSingleItem(context),
          ],
        ),
      ),
    );
  }

    Widget _buildAllItemList(BuildContext context,) {
    final provider = context.read<RecieptProvider>();
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      shrinkWrap: true,
      itemCount: provider.getAllItems(widget.currentReceiptID)?.length ?? 0,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildSingleItem(context, index),
            ),
            const Divider(height: 1, thickness: 1, color: Colors.black),
          ],
        );
      },
    );
  }

  List<Widget> _buildSingleItem(BuildContext context, int index) {
    final provider = context.read<RecieptProvider>().getReceipt[widget.currentReceiptID];
    return [
      Text(provider.items![index].name ?? 'Name $index'),
      Text(provider.items![index].cost?.toStringAsFixed(2) ?? '0.00'),
      Text('Holder $index'),
      _deleteSingleItem(context, index),
    ];
  }

  Widget _deleteSingleItem(BuildContext context, int index) {
    final provider = context.read<RecieptProvider>();
    return GestureDetector(
      onTap: () {
        setState(() {
          provider.deleteItem(widget.currentReceiptID, index);
        });
      },
      child: const Icon(
        Icons.delete,
        size: 30,
      )
    );
  }

  Widget _addSingleItem(BuildContext context) {
    final provider = context.read<RecieptProvider>();
    return GestureDetector(
      onTap: () {
        setState(() {
          provider.newItem(widget.currentReceiptID);
        });
      },
      child: const Icon(
        Icons.plus_one,
        size: 30,
      )
    );
  }
}
