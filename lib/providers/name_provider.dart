import 'package:flutter/material.dart';

import 'package:split_receipt/classes/classes.dart';

class NameProvider extends ChangeNotifier {
  final List<Profile> _profile = [
    Profile(nameID: 0, name: ""),
    Profile(nameID: 1, name: ""),
    Profile(nameID: 2, name: ""),
    Profile(nameID: 3, name: ""),
    Profile(nameID: 4, name: ""),
    Profile(nameID: 5, name: ""),
    Profile(nameID: 6, name: ""),
    Profile(nameID: 7, name: ""),
    Profile(nameID: 8, name: ""),
    Profile(nameID: 9, name: ""),
  ];

  void changeName({required int newNameID, required String newName}) {
    _profile[newNameID].name = newName;
  }
  
  List<Profile> get getProfile {
    return _profile;
  }

}