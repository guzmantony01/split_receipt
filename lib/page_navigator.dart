import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:split_receipt/pages/bill_page.dart';
import 'package:split_receipt/pages/breakdown_page.dart';
import 'package:split_receipt/pages/name_page.dart';
class PageNavigator extends StatefulWidget {
  const PageNavigator({required this.currentReceiptID, super.key});

  final int currentReceiptID;

  @override
  State<PageNavigator> createState() {
    return _PageNavigatorState();
  }
}

class _PageNavigatorState extends State<PageNavigator> {
  int pageID = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      BillPage(currentReceiptID: widget.currentReceiptID),
      BreakDownPage(),
      NamePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageID,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Bill'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Breakdown'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Names'),
        ],
        onTap: (int index) {
          setState(() {
            pageID = index;
          });
        }
      ),
      body: pages[pageID],
    );
  }
}
