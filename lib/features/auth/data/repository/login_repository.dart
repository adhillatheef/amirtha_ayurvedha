import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/login_model.dart';

class LoginRepository {
  Future<Login?> login({required String username, required String password}) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('https://flutter-amr.noviindus.in/api/Login'));
      request.fields.addAll({
        'username': username,
        'password': password
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Login loginResponse = loginFromJson(responseBody);
        return loginResponse;
      } else {
        debugPrint('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
      return null;
    }
  }
}
