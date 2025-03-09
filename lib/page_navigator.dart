import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:split_receipt/providers/item_provider.dart';
import 'package:split_receipt/providers/name_provider.dart';

import 'package:split_receipt/pages/bill_page.dart';
import 'package:split_receipt/pages/breakdown_page.dart';
import 'package:split_receipt/pages/name_page.dart';
class PageNavigator extends StatefulWidget {
  const PageNavigator({super.key});

  @override
  State<PageNavigator> createState() {
    return _PageNavigatorState();
  }
}

class _PageNavigatorState extends State<PageNavigator> {
  int pageID = 1;

  final List<Widget> pages = [
    const BillPage(),
    const BreakDownPage(),
    const NamePage(),
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
            context.read<NameProvider>().cleanUpProfiles();
            context.read<ItemProvider>().cleanUpItems();
          });
        }
      ),
      body: pages[pageID],
    );
  }
}
