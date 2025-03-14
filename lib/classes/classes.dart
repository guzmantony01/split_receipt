
class Profile {
  int nameID;
  String name;

  Profile(this.nameID, this.name);
}

class Item {
  int itemID;
  String itemName;
  double itemCost;
  String profileHolder;

  Item(this.itemID, this.itemName, this.itemCost, this.profileHolder);
}

class ExtraCost {
  double taxesAmount;
  double tipAmount;

  ExtraCost(this.taxesAmount, this.tipAmount);
}