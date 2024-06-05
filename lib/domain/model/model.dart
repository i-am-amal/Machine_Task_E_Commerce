class Items {
  int amount;
  String itemCode;
  String description;
  dynamic rate;
  int mrp;
  int price;
  int itemRate;

  Items({
    required this.amount,
    required this.itemCode,
    required this.description,
    required this.rate,
    required this.price,
    required this.itemRate,
    required this.mrp,
  });

  factory Items.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('json parameter must not be null');
    }

    return Items(
      amount: json['Amount'] as int? ?? 0,
      itemCode: json['ItemCode'] as String? ?? '',
      description: json['Description'] as String? ?? '',
      rate: json['Rate'] as int? ?? 0,
      mrp: json['MRP'] as int? ?? 0,
      price: json['Price'] as int? ?? 0,
      itemRate: json['ItemRate'] as int? ?? 0,
    );
  }
}

class ItemsList {
  List<Items> itemsList;
  ItemsList({required this.itemsList});
  factory ItemsList.fromJsonList(List<dynamic> jsonList) {
    List<Items> items = [];
    for (var jsonItem in jsonList) {
      items.add(Items.fromJson(jsonItem));
    }
    return ItemsList(itemsList: items);
  }
}
