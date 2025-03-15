import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:split_receipt/page_navigator.dart';
import 'package:split_receipt/providers/extrafees_provider.dart';
import 'package:split_receipt/providers/item_provider.dart';
import 'package:split_receipt/providers/name_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NameProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ItemProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExtraFeesProvider(),
        ),
      ],
      child: const MaterialApp(
        home: PageNavigator(),
      ),
    ),
  );
}
