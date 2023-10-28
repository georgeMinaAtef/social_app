
class CartItem {
  String? id;
  late String title;
  late double price;
  // late String description;
  // late String category;
  String? image;
  late int allQuantity;
  late int quantity;
  bool? inCart = false;

  CartItem(
      {
        this.id,
        this.inCart,
        required this.title,
        required this.price,
        // required this.description,
        // required this.category,
        required this.quantity,
        required this.allQuantity,
        required this.image});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inCart = json['inCart'];
    title = json['title'];
    price = json['price'];
    // description = json['description'];
    // category = json['category'];
    image = json['image'];
    quantity = json['quantity'];
    allQuantity = json['allQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['inCart'] = inCart;
    // data['description'] = description;
    // data['category'] = category;
    data['image'] = image;
    data['allQuantity'] = allQuantity;
    return data;
  }
}
