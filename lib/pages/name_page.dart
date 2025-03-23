import 'package:flutter/material.dart';
import 'package:split_receipt/model/classes.dart';
import 'package:provider/provider.dart';
import 'package:split_receipt/model/provider.dart';

class NamePage extends StatefulWidget {
  const NamePage({required this.currentReceiptID, super.key});
  
  final int currentReceiptID;

  @override
  State<NamePage> createState() {
    return _NamePageState();
  }
}


class _NamePageState extends State<NamePage> {
  List<TextEditingController> nameTextController = [];

  @override
  void initState() {
    super.initState();
    final receiptProvider = context.read<ReceiptProvider>();

    int nameLength = receiptProvider.receipts[widget.currentReceiptID].profiles.length;

    if (nameLength > 0) {
      for (int i = 0; i < nameLength; i++) {
        nameTextController.add(TextEditingController());
        nameTextController[i].text = receiptProvider.receipts[widget.currentReceiptID].profiles[i].name;
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
        child: Center(child: Text('Add Names'),),
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
            _buildProfileTableHeader(context),
            const Divider(height: 1, thickness: 1, color: Colors.black),
            _buildAllProfileList(context),
            _addSingleProfile(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTableHeader(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text('Name'),
          SizedBox(width: 30,),
        ],
      ),
    );
  }

  Widget _buildAllProfileList(BuildContext context,) {
    final receiptProvider = context.read<ReceiptProvider>();
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      shrinkWrap: true,
      itemCount: receiptProvider.receipts[widget.currentReceiptID].profiles.length,
      itemBuilder: (context, nameIndex) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildSingleProfile(context, nameIndex),
            ),
            const Divider(height: 1, thickness: 1, color: Colors.black),
          ],
        );
      },
    );
  }

  List<Widget> _buildSingleProfile(BuildContext context, int nameIndex) {
    final receiptProvider = context.read<ReceiptProvider>();
    return [
      Expanded(
        child: TextFormField(
          decoration: const InputDecoration(
            label: Text('Name'),
          ),
          controller: nameTextController[nameIndex],
          onChanged: (value) {
            receiptProvider.receipts[widget.currentReceiptID].profiles[nameIndex].name = value;
          },
        ),
      ),
      _deleteSingleProfile(context, nameIndex),
    ];
  }

  Widget _deleteSingleProfile(BuildContext context, int nameIndex) {
    final receiptProvider = context.read<ReceiptProvider>().receipts[widget.currentReceiptID];
    return GestureDetector(
      onTap: () {
        setState(() {
          receiptProvider.profiles.removeAt(nameIndex);
          nameTextController.removeAt(nameIndex);
        });
      },
      child: const Icon(
        Icons.delete,
        size: 30,
      )
    );
  }

  Widget _addSingleProfile(BuildContext context) {
    final receiptProvider = context.read<ReceiptProvider>();
    return GestureDetector(
      onTap: () {
        setState(() {
          receiptProvider.addProfile(widget.currentReceiptID, Profile.create());

          nameTextController.add(TextEditingController());

          nameTextController[nameTextController.length - 1].text = '';
        });
      },
      child: const Icon(
        Icons.plus_one,
        size: 30,
      )
    );
  }
}