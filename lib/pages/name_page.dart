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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          NameHandler(nameID: 0),
          NameHandler(nameID: 1),
          NameHandler(nameID: 2),
          NameHandler(nameID: 3),
          NameHandler(nameID: 4),
          NameHandler(nameID: 5),
          NameHandler(nameID: 6),
          NameHandler(nameID: 7),
          NameHandler(nameID: 8),
          NameHandler(nameID: 9),
        ],
      ),
    );
  }
}