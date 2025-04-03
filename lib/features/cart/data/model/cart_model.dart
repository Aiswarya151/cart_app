// To parse this JSON data, do
//
//     final carttModel = carttModelFromJson(jsonString);

import 'dart:convert';

CartModel carttModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String carttModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
    String? id;
    List<dynamic>? items;
    int? v;

    CartModel({
        this.id,
        this.items,
        this.v,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["_id"],
        items: json["items"] == null ? [] : List<dynamic>.from(json["items"]!.map((x) => x)),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x)),
        "__v": v,
    };
}
