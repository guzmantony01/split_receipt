import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:split_receipt/providers/name_provider.dart';

import 'package:split_receipt/misc/breakdown_handler.dart';


class BreakDownPage extends StatefulWidget {
  const BreakDownPage({super.key});

  @override
  State<BreakDownPage> createState() {
    return _BreakDownPageState();
  }
}

class _BreakDownPageState extends State<BreakDownPage> {

  final List<String> test = [
    "test1",
    "test2"
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NameProvider>(builder: (context, providerItem, child) {
      return Scaffold(
        body: ListView(
          children: const [
            BreakdownHandler(nameID: 0),
            BreakdownHandler(nameID: 1),
            BreakdownHandler(nameID: 2),
            BreakdownHandler(nameID: 3),
            BreakdownHandler(nameID: 4),
            BreakdownHandler(nameID: 5),
            BreakdownHandler(nameID: 6),
            BreakdownHandler(nameID: 7),
            BreakdownHandler(nameID: 8),
            BreakdownHandler(nameID: 9),
          ],
        ),
      );
    });
  }
}