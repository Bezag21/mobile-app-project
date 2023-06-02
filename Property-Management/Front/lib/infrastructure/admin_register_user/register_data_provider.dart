import 'dart:convert';

import '../../../domain/admin_register_user/admin_register_user_domian.dart';
import '../../../infrastructure/endpoints/endpoint.dart';
import 'package:http/http.dart' as http;

class AdminProvider {
  

Future<void> createUser(AddUserDomainRequest user) async {

  final response = await http.post(
        Uri.parse(
            "${EndPoint().baseUrl}${EndPoint().auth}/${EndPoint().signup}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(user));

    if (response.statusCode == 200) {
      print("added");
    } else {
      print("provider");
      throw Exception("adding Failed");
    }

}
}


