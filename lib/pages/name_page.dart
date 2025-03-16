import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Text("Add Names", style: TextStyle(fontSize: 20),),
          ),
        ],
      ),
    );
  }
}