class InspectionModel {
  String name;
  String descrption;
  String address;
  String? id;

  InspectionModel(
      {required this.name,
      required this.descrption,
      required this.address,
      this.id});

  factory InspectionModel.fromJson(Map<String, dynamic> json) => InspectionModel(
      name: json["name"],
      descrption: json["descrption"],
      address: json["address"],
      id: json["_id"]);

  Map<String, dynamic> toJson() =>
      {"name": name, "address":address, "descrption": descrption, "_id": id};
}
