import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BreakDownPage extends StatefulWidget {
  const BreakDownPage({super.key});

  @override
  State<BreakDownPage> createState() {
    return _BreakDownPageState();
  }
}

class _BreakDownPageState extends State<BreakDownPage> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Text("Breakdown Cost", style: TextStyle(fontSize: 20),),
          ),
        ],
      ),
    );
  }
}