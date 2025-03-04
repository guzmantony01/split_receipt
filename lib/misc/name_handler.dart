import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:split_receipt/providers/name_provider.dart';

class NameHandler extends StatefulWidget {
  const NameHandler({required this.nameID, super.key});

  final int nameID;

  @override
  State<NameHandler> createState() {
    return _NameHandlerState();
  }
}

class _NameHandlerState extends State<NameHandler> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<NameProvider>(builder: (context, providerItem, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          color: Colors.grey[300],
          child: TextField(
            onChanged: (String text) => providerItem.changeName(newNameID: widget.nameID, newName: text),
          ),
        ),
      );
    });
  }
}
