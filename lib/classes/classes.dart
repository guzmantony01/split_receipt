
class Profile {
  int nameID;
  String name;
  int itemID;

  Profile({required this.nameID, required this.name, required this.itemID});
}

class BillableItems {
  int itemID;
  String itemName;
  double itemCost;

  BillableItems({required this.itemID, required this.itemName, required this.itemCost});
}