import 'package:flutter/material.dart';

class NameHandler extends StatefulWidget {
  final void Function(int, String) myCallback;
  const NameHandler({required this.nameID, required this.myCallback, super.key});

  final nameID;

  @override
  State<NameHandler> createState() {
    return _NameHandlerState();
  }
}

class _NameHandlerState extends State<NameHandler> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        color: Colors.deepPurple[200],
        child: TextField(
          onChanged: (String text) => widget.myCallback(widget.nameID, text),
        ),
      ),
    );
  }
}
