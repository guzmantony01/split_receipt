import 'dart:convert';  // For JSON encoding and decoding

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

  // Receipt creation with default entries
  factory Receipt.create({
    required int id,
    required String name,
    required List<Profile> profiles,
    required List<Item> items,
    required Fees fees,
  }) {
    return Receipt(
      id: id,
      name: 'Receipt #$id',
      profiles: profiles,
      items: items,
      fees: fees,
    );
  }

  // Convert Receipt object to Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      // Handled by encoding via json due to it being List<Class> but has to be mapped to convert everything to String
      'profiles': jsonEncode(profiles.map((profiles) => profiles.toMap()).toList()),
      'items': jsonEncode(items.map((items) => items.toMap()).toList()),
      // Handled by encoding via json due to being custom class
      'fees': fees.toJson(),
    };
  }

  // Convert Map to Receipt object
  factory Receipt.fromMap(Map<String, dynamic> map) {
    // Deserialize profiles, items, and fees
    var profilesJson = map['profiles'] as String;
    var itemsJson = map['items'] as String;
    var feesJson = map['fees'] as String;

    List<Profile> profilesList = (jsonDecode(profilesJson) as List)
        .map((profileMap) => Profile.fromMap(profileMap))
        .toList();
    List<Item> itemsList = (jsonDecode(itemsJson) as List)
        .map((itemMap) => Item.fromMap(itemMap))
        .toList();
    Fees fees = Fees.fromJson(feesJson);

    return Receipt(
      id: map['id'],
      name: map['name'],
      profiles: profilesList,
      items: itemsList,
      fees: fees,
    );
  }
}

class Profile {
  String name;

  Profile({
    required this.name,
  });

  // Profile creation with default entries
  factory Profile.create({
    String name = '',
  }) {
    return Profile(
      name: name,
    );
  }

  // Convert Profile object to Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  // Convert Map to Profile object
  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      name: map['name']
    );
  }

  // Convert Profile object to JSON (to store in Receipt object as a string)
  String toJson() {
    return jsonEncode(toMap());
  }

  // Convert JSON string back to Profile object
  factory Profile.fromJson(String jsonStr) {
    final map = jsonDecode(jsonStr);
    return Profile.fromMap(map);
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

  // Item creation with default entries
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

  // Convert Item object to Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cost': cost,
      'buyer': buyer,
    };
  }

  // Convert Map to Item object
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      name: map['name'],
      cost: map['cost'],
      buyer: map['buyer'],
    );
  }

  // Convert Item object to JSON (to store in Receipt object as a string)
  String toJson() {
    return jsonEncode(toMap());
  }

  // Convert JSON string back to Item object
  factory Item.fromJson(String jsonStr) {
    final map = jsonDecode(jsonStr);
    return Item.fromMap(map);
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

  // Profile creation with default entries
  factory Fees.create({
    double tax = 0.00,
    double tip = 0.00,
  }) {
    return Fees(
      tax: tax,
      tip: tip,
    );
  }

  // Convert Fees object to Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'tax': tax,
      'tip': tip,
    };
  }

  // Convert Map to Fees object
  factory Fees.fromMap(Map<String, dynamic> map) {
    return Fees(
      tax: map['tax'],
      tip: map['tip'],
    );
  }

  // Convert Fees object to JSON (to store in Receipt object as a string)
  String toJson() {
    return jsonEncode(toMap());
  }

  // Convert JSON string back to Fees object
  factory Fees.fromJson(String jsonStr) {
    final map = jsonDecode(jsonStr);
    return Fees.fromMap(map);
  }
}

