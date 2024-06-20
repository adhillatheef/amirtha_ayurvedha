import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/patient_model.dart';

class HomeScreenRepository {
  Future<List<PatientElement>?> getPatients(String token) async {
    try {
      var headers = {
        'Authorization': 'Bearer $token',
      };
      var request = http.Request('GET', Uri.parse('https://flutter-amr.noviindus.in/api/PatientList'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Patient patientResponse = patientFromJson(responseBody);
        if (patientResponse.status == true) {
          return patientResponse.patient;
        } else {
          debugPrint('Failed to get patients: ${patientResponse.message}');
          return null;
        }
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
