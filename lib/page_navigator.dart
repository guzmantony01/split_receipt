import 'package:flutter/material.dart';
import 'package:split_receipt/model/provider.dart';
import 'package:split_receipt/pages/bill_page.dart';
import 'package:split_receipt/pages/breakdown_page.dart';
import 'package:split_receipt/pages/name_page.dart';
import 'package:provider/provider.dart';
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
  int currentReceiptID = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      NamePage(currentReceiptID: widget.currentReceiptID),
      BillPage(currentReceiptID: widget.currentReceiptID),
      BreakDownPage(currentReceiptID: widget.currentReceiptID),
    ];
  }

  void cleanUp(int pageID) {
    final receiptProvider = context.read<ReceiptProvider>().receipts[widget.currentReceiptID];
    if (pageID == 0) { // Previous was NamePage
      int nameLength = receiptProvider.profiles.length;
      for (int nameIndex = 0; nameIndex < nameLength; nameIndex++) {
        if (receiptProvider.profiles[nameIndex].name == '') {
          receiptProvider.profiles.removeAt(nameIndex);
          nameIndex--;
          nameLength--;
        }
      }
    } else if (pageID == 1) { // Previous was BillPage
      int itemLength = receiptProvider.items.length;
      for (int itemIndex = 0; itemIndex < itemLength; itemIndex++) {
        if (receiptProvider.items[itemIndex].name == '') {
          receiptProvider.items.removeAt(itemIndex);
          itemIndex--;
          itemLength--;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageID,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Names'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Bill'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Breakdown'),
        ],
        onTap: (int index) {
          setState(() {
            cleanUp(pageID);
            pageID = index;
          });
        }
      ),
      body: pages[pageID],
    );
  }
}
