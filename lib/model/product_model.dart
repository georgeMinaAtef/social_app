import 'dart:io';

class ProductList {
  List<ProductModel>? data;

  ProductList(this.data);

  ProductList.fromJson(List<dynamic> json) {
    data = json.map((productJson) => ProductModel.fromJson(productJson)).toList();
  }
}

class ProductModel {
  String? id;
  late String title;
  late double price;
  late String description;
  late String category;
  String? image;
  bool? inCart = false;
  late int quantity;

  ProductModel(
      {
        this.id,
        this.inCart,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.quantity,
        this.image});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inCart = json['inCart'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['image'] = image;
    data['inCart'] = inCart;
    return data;
  }
}
