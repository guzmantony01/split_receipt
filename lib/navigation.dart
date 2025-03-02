import 'package:flutter/material.dart';

class Navigator extends StatefulWidget {
  const Navigator({super.key});

  @override
  State<Navigator> createState() {
    return _NavigatorState();
  }
}

class _NavigatorState extends State<Navigator> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Bill'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Party Breakdown'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Party'),
          ]
        );
  }
}