import 'package:flutter/material.dart';
import 'package:split_receipt/misc/name_handler.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() {
    return _NamePageState();
  }
}

class _NamePageState extends State<NamePage> {

  void updatedName (String name) {
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          NameHandler(myCallback: updatedName),
          NameHandler(myCallback: updatedName),
        ],
      ),
    );
  }
}