import 'package:flutter/material.dart';
import 'package:split_receipt/model/classes.dart';
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
  List<TextEditingController> itemNameTextController = [];
  List<TextEditingController> itemCostTextController = [];
  List<TextEditingController> buyerTextController = [];

  @override
  void initState() {
    super.initState();
    final receiptProvider = context.read<ReceiptProvider>();

    // Get length of the receipts.items length
    int itemLength = receiptProvider.receipts[widget.currentReceiptID].items.length;
    if (itemLength > 0) {
      // Loop through every item
      for (int itemIndex = 0; itemIndex < itemLength; itemIndex++) {
        // Add a TextController for every receipts.items length
        itemNameTextController.add(TextEditingController());
        itemCostTextController.add(TextEditingController());
        buyerTextController.add(TextEditingController());

        // Get receipts.items.name and receipts.items.cost and put into their respective TextController
        itemNameTextController[itemIndex].text = receiptProvider.receipts[widget.currentReceiptID].items[itemIndex].name;
        itemCostTextController[itemIndex].text = receiptProvider.receipts[widget.currentReceiptID].items[itemIndex].cost.toStringAsFixed(2);
        buyerTextController[itemIndex].text = receiptProvider.receipts[widget.currentReceiptID].items[itemIndex].buyer;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
        child: Column(
          children: [
            _buildTitle(context),
            _buildList(context),
            _buildFees(context)
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
            _buildItemTableHeader(context),
            const Divider(height: 1, thickness: 1, color: Colors.black),
            _buildAllItemList(context),
            _addSingleItem(context),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTableHeader(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text('Item Name'),
          ),
          Expanded(
            flex: 1,
            child: Text('Cost'),
          ),
          Expanded(
            flex: 3,
            child: Text('Buyer'),
          ),
          SizedBox(width: 30,),
        ],
      ),
    );
  }

  Widget _buildAllItemList(BuildContext context) {
    final receiptProvider = context.read<ReceiptProvider>();
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      shrinkWrap: true,
      itemCount: receiptProvider.receipts[widget.currentReceiptID].items.length,
      itemBuilder: (context, itemIndex) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildSingleItem(context, itemIndex),
            ),
            const Divider(height: 1, thickness: 1, color: Colors.black),
          ],
        );
      },
    );
  }

  List<Widget> _buildSingleItem(BuildContext context, int itemIndex) {
    final receiptProvider = context.read<ReceiptProvider>();
    return [
      // Handles the Item Name portion per item
      Expanded(
        flex: 2,
        child: TextFormField(
          decoration: const InputDecoration(
            label: Text('Name'),
          ),
          controller: itemNameTextController[itemIndex],
          onChanged: (value) {
            receiptProvider.receipts[widget.currentReceiptID].items[itemIndex].name = value;
          },
        ),
      ),
      // Handles the Item Cost portion per item
      Expanded(
        flex: 1,
        child: TextFormField(
          decoration: const InputDecoration(
            label: Text('Cost'),
          ),
          controller: itemCostTextController[itemIndex],
          onChanged: (value) {
            receiptProvider.receipts[widget.currentReceiptID].items[itemIndex].cost = double.tryParse(value) ?? 0.00;
          },
        ),
      ),
      // Handles the Item Buyer portion per item
      Expanded(
        flex: 3,
        child: TextFormField(
          decoration: const InputDecoration(
            label: Text('Buyer'),
          ),
          controller: buyerTextController[itemIndex],
          onChanged: (value) {
            receiptProvider.receipts[widget.currentReceiptID].items[itemIndex].buyer = value;
          },
        ),
      ),
      // Handles the deletion of an item
      _deleteSingleItem(context, itemIndex),
    ];
  }

  Widget _deleteSingleItem(BuildContext context, int itemIndex) {
    final receiptProvider = context.read<ReceiptProvider>().receipts[widget.currentReceiptID];
    return GestureDetector(
      onTap: () {
        setState(() {
          receiptProvider.items.removeAt(itemIndex);
          itemNameTextController.removeAt(itemIndex);
          itemCostTextController.removeAt(itemIndex);
          buyerTextController.removeAt(itemIndex);
        });
      },
      child: const Icon(
        Icons.delete,
        size: 30,
      )
    );
  }

  Widget _addSingleItem(BuildContext context) {
    final receiptProvider = context.read<ReceiptProvider>();
    return GestureDetector(
      onTap: () {
        setState(() {
          receiptProvider.addItem(widget.currentReceiptID, Item.create());

          itemNameTextController.add(TextEditingController());
          itemCostTextController.add(TextEditingController());
          buyerTextController.add(TextEditingController());

          itemNameTextController[itemNameTextController.length - 1].text = '';
          itemCostTextController[itemCostTextController.length - 1].text = '0.00';
          buyerTextController[buyerTextController.length - 1].text = '';
        });
      },
      child: const Icon(
        Icons.plus_one,
        size: 30,
      )
    );
  }

  Widget _buildFees(BuildContext context) {
    return const SizedBox(
      child: Card(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          side: BorderSide(
            width: 2.0,
            color: Colors.black,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tax'),
                  Text('Cost'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tip'),
                  Text('Cost'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total'),
                  Text('Cost'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
