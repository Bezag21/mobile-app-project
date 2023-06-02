import 'dart:convert';

class User{
  String id;
  String email;
  String name;
  String roles;
  

  
  User({required this.email, required this.name , required this.roles ,  required this.id});
  factory User.fromJson(Map<String, dynamic> json) => User(email: json["email"], name: json["name"] , roles: json["roles"] , id: json["_id"]);
  Map<String, dynamic> toJson() => {"email": email, "name": name, "roles": roles, "id": id};
  
  }
