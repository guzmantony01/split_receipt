import 'package:flutter/material.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() {
    return _NamePageState();
  }
}

class _NamePageState extends State<NamePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.green),
            child: const Text('name1'),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.green),
            child: const Text ('name2'),
          ),
        ],
      ),
    );
  }
}