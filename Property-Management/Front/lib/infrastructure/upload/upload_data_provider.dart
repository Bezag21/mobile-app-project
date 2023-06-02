import 'dart:convert';

import 'package:property/domain/upload/upload_Domain.dart';

import '../../../infrastructure/core/sharedPref.dart';
import '../../../infrastructure/endpoints/endpoint.dart';
import '../../../infrastructure/upload/upload_model.dart';
import 'package:http/http.dart' as http;

class UploadProvider {
  Future<void> createUpload(UploadModel uploadModel) async {
    SharedPref pref = SharedPref();
    String? token = await pref.getToken();

    final response = await http.post(
        Uri.parse('${EndPoint().baseUrl}${EndPoint().upload}'),
        headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!
        },
        body: jsonEncode(uploadModel));

    if (response.statusCode == 201) {
      print(response.body);
      
    } else {
      throw Exception('failed to create ');
    }
  }

  Future<List<UploadModel>> getAllUploads() async {
    SharedPref pref = SharedPref();
    final token = await pref.getToken();

    final response = await http.get(
        Uri.parse('${EndPoint().baseUrl}${EndPoint().upload}'),
        headers: {"Access-Control-Allow-Origin": "*", "token": token!});

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["inspections"];
      final List<UploadModel> inspections =
          list.map((value) => UploadModel.fromJson(value)).toList();
      return inspections;
    } else {
      throw Exception("error fetching ");
    }
  }

  Future<UploadModel> getUpload(id) async {
    final response = await http.get(
        Uri.parse('${EndPoint().baseUrl}${EndPoint().upload}'),
        headers: {"Access-Control-Allow-Origin": "*"});

    if (response.statusCode == 200) {
      return UploadModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("error fetching");
    }
  }

  
  Future<void> deleteUpload(String id) async {
    final response = await http.delete(
      Uri.parse('${EndPoint().upload}$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode != 200) {
      print(response.body);
      throw Exception('failed to delete');
    }
  }

  Future<void> editUpload(UploadModel uploadModel) async {
    final response = await http.patch(
     
        Uri.parse('${EndPoint().baseUrl}${EndPoint().inspection}/${uploadModel.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(uploadModel));
    if (response.statusCode != 204) {
      throw Exception('failed to to edit');
    }
  }

  Future<UploadModel> searchUpload(String name) async {
    print("parahere");
    SharedPref pref = SharedPref();
    final token = await pref.getToken();
    final response = await http.get(
        Uri.parse(EndPoint().baseUrl + EndPoint().upload+ "/upload"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "token": token!,
          "name": name
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      final json = jsonDecode(response.body);
      final insp =UploadModel.fromJson(json);
      return insp;
    } else {
      print("throwed");
      throw Exception("error fetching ");
    }
  }
}
