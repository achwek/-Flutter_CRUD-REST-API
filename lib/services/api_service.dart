import 'dart:convert';


import 'package:flutterwithjsonserver/models/cases.dart';
import 'package:http/http.dart';

class ApiService {
final Uri apiUrl = Uri.parse('http://localhost:3000/cases');
 Future<List<Cases>> getCases() async {
  Response res = await get(apiUrl);

  if (res.statusCode == 200) {
    List<dynamic> body = jsonDecode(res.body);
    List<Cases> cases = body.map((dynamic item) => Cases.fromJson(item)).toList();
    return cases;
  } else {
    throw Exception('Failed to load cases list');
  }
}


  Future<Cases> getCaseById(String id) async {
    final response = await get('$apiUrl/$id' as Uri);

    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<Cases> createCase(Cases cases) async {
    Map data = {
      'name': cases.name,
      'gender': cases.gender,
      'age': cases.age,
      'address': cases.address,
      'city': cases.city,
      'country': cases.country,
      'status': cases.status
    };

    final Response response = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 201) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post cases');
    }
  }

  Future<Cases> updateCases(String id, Cases cases) async {
    Map data = {
      'name': cases.name,
      'gender': cases.gender,
      'age': cases.age,
      'address': cases.address,
      'city': cases.city,
      'country': cases.country,
      'status': cases.status
    };

    final Response response = await put(
      '$apiUrl/$id' as Uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteCase(String id) async {
    Response res = await delete('$apiUrl/$id' as Uri);

    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }

}