
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

class ExtraFees {
  double taxesAmount;
  double taxesPercent;
  double tipAmount;
  double tipPercent;

  ExtraFees(this.taxesAmount, this.taxesPercent, this.tipAmount, this.tipPercent);
}