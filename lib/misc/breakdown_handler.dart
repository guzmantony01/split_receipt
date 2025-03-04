import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:split_receipt/providers/item_provider.dart';
import 'package:split_receipt/providers/name_provider.dart';

class BreakdownHandler extends StatefulWidget {
  const BreakdownHandler({required this.nameID, super.key});

  final int nameID;

  @override
  State<BreakdownHandler> createState() {
    return _BreakdownHandlerState();
  }
}

class _BreakdownHandlerState extends State<BreakdownHandler> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer2<NameProvider, ItemProvider>(
      builder: (context, providerName, providerItem, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 70,
          color: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                providerName.getProfile[widget.nameID].name,
                style: const TextStyle(fontSize: 25, color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'ItemName: ${providerItem.getItems[widget.nameID].itemName}',
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    'Cost: \$${providerItem.getItems[widget.nameID].itemCost.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
