import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:split_receipt/model/provider.dart';
import 'package:split_receipt/pages/home_page.dart';

// Version 1.0
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ReceiptProvider(),
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
