import 'package:flutter/material.dart';

import 'package:split_receipt/pages/bill_page.dart';
import 'package:split_receipt/pages/breakdown_page.dart';
import 'package:split_receipt/pages/name_page.dart';

import 'package:split_receipt/classes/classes.dart';

class PageNavigator extends StatefulWidget {
  const PageNavigator({super.key});

  @override
  State<PageNavigator> createState() {
    return _PageNavigatorState();
  }
}

class _PageNavigatorState extends State<PageNavigator> {
  int pageID = 0;

  void updatedName (int nameID, String name) {
    print('This is _PageNavigatorState'+'$nameID: $name');
  }

  final List<Widget> pages = [
    const BillPage(),
    const BreakDownPage(),
    NamePage(myCallback: updatedName),
  ];

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
            debugPrint('Im on this page');
            debugPrint('$pageID');
          });
        }
      ),
      body: pages[pageID],
    );
  }
}
