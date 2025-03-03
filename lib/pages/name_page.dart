import 'package:flutter/material.dart';
import 'package:split_receipt/misc/name_handler.dart';

class NamePage extends StatefulWidget {
  final void Function(int, String) myCallback;
  const NamePage({required this.myCallback, super.key});

  @override
  State<NamePage> createState() {
    return _NamePageState();
  }
}

class _NamePageState extends State<NamePage> {

  void updatedText (int nameID, String name) {
    print('This is _NamePageState'+'$nameID: $name');
    () => widget.myCallback(nameID, name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          NameHandler(nameID: 1, myCallback: updatedText),
          NameHandler(nameID: 2, myCallback: updatedText),
        ],
      ),
    );
  }
}