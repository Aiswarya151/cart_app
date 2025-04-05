// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
    List<Item>? items;

    CartModel({
        this.items,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    String? productId;
    String? name;
    String? price;
    int? quantity;

    Item({
        this.productId,
        this.name,
        this.price,
        this.quantity,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: json["productId"],
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "price": price,
        "quantity": quantity,
    };
}
