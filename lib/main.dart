import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:split_receipt/model/provider.dart';

import 'package:split_receipt/pages/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RecieptProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
        home: const Scaffold(
          body: HomePage(),
        ),
      ),
    ),
  );
}
