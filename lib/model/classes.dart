class Receipt {
  int id;
  String name;
  List<Profile> profiles;
  List<Item> items;
  Fees fees;

  Receipt({
    required this.id,
    required this.name,
    required this.profiles,
    required this.items,
    required this.fees,
  });

  factory Receipt.create({
    required int id,
    required String name,
    required List<Profile> profiles,
    required List<Item> items,
    Fees? fees,
  }) {
    return Receipt(
      id: id,
      name: 'Receipt #$id',
      profiles: profiles,
      items: items,
      fees: fees ?? Fees(tax: 0.0, tip: 0.0), // Default fees if not provided
    );
  }
}

class Profile {
  String name;

  Profile({
    required this.name,
  });

  factory Profile.create({
    String name = '',
  }) {
    return Profile(
      name: name,
    );
  }
}

class Item {
  String name;
  double cost;
  String buyer;

  Item({
    required this.name,
    required this.cost,
    required this.buyer,
  });

  factory Item.create({
    String name = '',
    double cost = 0.00,
    String buyer = '',
  }) {
    return Item(
      name: name,
      cost: cost,
      buyer: buyer,
    );
  }
}

class Fees {
  double tax;
  double tip;

  Fees({
    required this.tax,
    required this.tip,
  });

  double get total => tax + tip;
}

