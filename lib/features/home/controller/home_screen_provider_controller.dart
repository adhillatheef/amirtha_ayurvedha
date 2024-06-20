import 'package:amirtha_ayurvedha/common/secrets/token.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/model/patient_model.dart';
import '../data/repository/home_screen_repository.dart';

class HomeProvider with ChangeNotifier {
  List<PatientElement>? _patients;
  bool _isLoading = false;
  String? _errorMessage;

  List<PatientElement>? get patients => _patients;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPatients() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    HomeScreenRepository repository = HomeScreenRepository();
    List<PatientElement>? patientsList = await repository.getPatients(Secrets.token);

    _isLoading = false;
    if (patientsList != null) {
      _patients = patientsList;
    } else {
      _errorMessage = 'Failed to fetch patients';
    }
    notifyListeners();
  }
}
