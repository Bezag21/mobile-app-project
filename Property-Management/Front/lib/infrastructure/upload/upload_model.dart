import 'dart:io';
class UploadModel {
  String address;
  String descrption;
  String price;
 File? image;
  String? id;

  UploadModel( 
      {
      required this.address,
      required this.descrption,
      required this.price,
      required this.image,
      this.id});

  factory UploadModel.fromJson(Map<String, dynamic> json) => UploadModel(
      address: json['address'],
      descrption: json["descrption"],
      price: json["price"],
      image: json['image'],
      id: json["_id"]);

  Map<String, dynamic> toJson() =>
      { "address": address, "descrption": descrption, "price":price, "_id": id};
}
