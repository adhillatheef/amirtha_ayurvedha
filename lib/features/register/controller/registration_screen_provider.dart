import 'package:flutter/material.dart';
import '../../../common/secrets/token.dart';
import '../data/model/branch_list_model.dart';
import '../data/repository/registration_repository.dart';

class RegistrationScreenProvider extends ChangeNotifier {
  final RegistrationRepository _registrationRepository = RegistrationRepository();

  List<String> _treatmentList = [];
  List<String> get treatmentList => _treatmentList;

  List<Branch> _branchList = [];
  List<Branch> get branchList => _branchList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void getTreatmentList() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<String> treatments = await _registrationRepository.getTreatmentsList(Secrets.token);
      _treatmentList = treatments;
    } catch (e) {
      debugPrint('An error occurred while fetching the treatment list: $e');
      _treatmentList = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void getBranchList() async {
    _isLoading = true;
    notifyListeners();

    try {
      BranchList? branchList = await _registrationRepository.getBranchList(Secrets.token);

      if (branchList != null && branchList.status == true && branchList.branches != null) {
        _branchList = branchList.branches!;
      } else {
        debugPrint('Failed to fetch branch list.');
        _branchList = [];
      }
    } catch (e) {
      debugPrint('An error occurred while fetching the branch list: $e');
      _branchList = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
