import 'dart:convert';
import '../../../infrastructure/auth/login_model.dart';
import '../../../infrastructure/auth/login_response_model.dart';
import '../../../infrastructure/endpoints/endpoint.dart';
import 'package:http/http.dart' as http;


class AuthDataProvider {
  Future<LoginResponse> login(LoginUser loginUser) async {
    final response = await http.post(
        Uri.parse(
            "${EndPoint().baseUrl}${EndPoint().auth}/${EndPoint().login}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(loginUser));
    print(response);
    if (response.statusCode == 200) {
      print("provider suceed");
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      print("provider failed");
      throw Exception("Failed to Login");
    }
  }
}
