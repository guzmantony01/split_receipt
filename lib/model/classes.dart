class Receipt {
  int id;
  List<Profile>? profiles;
  List<Item>? items;
  Fees? fees;

  Receipt(this.id, this.profiles, this.items, this.fees);
}

class Profile {
  String name;
  List<Item> items;

  Profile(this.name, this.items);
}

class Item {
  int id;
  String? name;
  double? cost;

  Item(this.id, this.name, this.cost);
}

class Fees {
  double tax;
  double tip;

  Fees(this.tax, this.tip);
}