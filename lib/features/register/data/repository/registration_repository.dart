import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/branch_list_model.dart';
import '../model/treatment_list_model.dart';

class RegistrationRepository {
  Future<List<String>> getTreatmentsList(String token) async {
    var headers = {
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse('https://flutter-amr.noviindus.in/api/TreatmentList'));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        TreatmentList treatmentList = treatmentListFromJson(responseBody);

        if (treatmentList.status == true && treatmentList.treatments != null) {
          List<String> treatmentNames = treatmentList.treatments!.map((treatment) => treatment.name ?? 'Unnamed Treatment').toList();
          return treatmentNames;
        } else {
          debugPrint('Failed to get treatments: ${treatmentList.message}');
          return [];
        }
      } else {
        debugPrint('Error: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      debugPrint('An error occurred: $e');
      return [];
    }
  }

  Future<BranchList?> getBranchList(String token) async {
    var headers = {
      'Authorization': 'Bearer $token'
    };

    var request = http.Request('GET', Uri.parse('https://flutter-amr.noviindus.in/api/BranchList'));
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        BranchList branchList = branchListFromJson(responseBody);

        if (branchList.status == true && branchList.branches != null) {
          return branchList;
        } else {
          debugPrint('Failed to get branch list: ${branchList.message}');
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
