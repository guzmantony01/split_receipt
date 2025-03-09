import 'package:flutter/material.dart';

import 'package:split_receipt/classes/classes.dart';

class NameProvider extends ChangeNotifier {
  final List<Profile> _profile = [
    Profile(0, ""),
  ];

  void addProfile({required int newNameID, required String newName}) {
    _profile.add(Profile(newNameID, newName));
  }

  void updateProfile({required int updatingNameID, required String newName}) {
    _profile[updatingNameID].name = newName;
  }

  void removeProfile({required int inputNameID}) {
    _profile.removeAt(inputNameID);
  }

  void cleanUpProfiles() {
    for(int i = 0; i < _profile.length; i++) {
      if(_profile[i].name.isEmpty) {
        _profile.removeAt(i);
        i -= 1;
      }
    }
  }

  List<String> getDropDownMenuEntries() {
    List<String> nameList = [];
    nameList.add("");
    for(int i = 0; i < _profile.length; i++) {
      nameList.add(_profile[i].name);
    }
    return nameList;
  }
  
  List<Profile> get getProfile {
    return _profile;
  }
}