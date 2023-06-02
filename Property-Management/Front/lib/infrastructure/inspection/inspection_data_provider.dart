import 'dart:convert';

import 'package:property/domain/inspection/inspection_Domain.dart';

import '../../../infrastructure/core/sharedPref.dart';
import '../../../infrastructure/endpoints/endpoint.dart';
import '../../../infrastructure/inspection/inspection_model.dart';
import 'package:http/http.dart' as http;

class InspectionProvider {
  Future<void> createInspection(InspectionModel inspectionModel) async {
    SharedPref pref = SharedPref();
    String? token = await pref.getToken();

    final response = await http.post(
        Uri.parse('${EndPoint().baseUrl}${EndPoint().inspection}'),
        headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!
        },
        body: jsonEncode(inspectionModel));

    if (response.statusCode == 201) {
      print(response.body);
      
    } else {
      throw Exception('failed to create inspection');
    }
  }

  Future<List<InspectionModel>> getAllInspection() async {
    SharedPref pref = SharedPref();
    final token = await pref.getToken();

    final response = await http.get(
        Uri.parse('${EndPoint().baseUrl}${EndPoint().inspection}'),
        headers: {"Access-Control-Allow-Origin": "*", "token": token!});

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["inspections"];
      final List<InspectionModel> inspections =
          list.map((value) => InspectionModel.fromJson(value)).toList();
      return inspections;
    } else {
      throw Exception("error fetching inspection");
    }
  }

  Future<InspectionModel> getInspection(id) async {
    final response = await http.get(
        Uri.parse('${EndPoint().baseUrl}${EndPoint().inspection}'),
        headers: {"Access-Control-Allow-Origin": "*"});

    if (response.statusCode == 200) {
      return InspectionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("error fetching inspection");
    }
  }

  
  Future<void> deleteInspection(String id) async {
    final response = await http.delete(
      Uri.parse('${EndPoint().inspection}$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode != 200) {
      print(response.body);
      throw Exception('failed to delete');
    }
  }

  Future<void> editInspection(InspectionModel inspectionModel) async {
    final response = await http.patch(
     
        Uri.parse('${EndPoint().baseUrl}${EndPoint().inspection}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(inspectionModel));
    if (response.statusCode != 204) {
      throw Exception('failed to to edit');
    }
  }

  Future<InspectionModel> searchInspection(String name) async {
    print("parahere");
    SharedPref pref = SharedPref();
    final token = await pref.getToken();
    final response = await http.get(
        Uri.parse(EndPoint().baseUrl + EndPoint().inspection+ "/inspection"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "token": token!,
          "name": name
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      final json = jsonDecode(response.body);
      final insp = InspectionModel.fromJson(json);
      return insp;
    } else {
      print("throwed");
      throw Exception("error fetching inspection");
    }
  }
}
