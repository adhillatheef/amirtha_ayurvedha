import 'package:flutter/material.dart';
import '../../../common/widgets/common_button.dart';
import '../data/model/treatment_model.dart';
import 'gender_counter_widget.dart';
import 'textfield_with_dropdown.dart';
import '../../../common/sized_box/sized_box.dart';

class TreatmentDialog extends StatefulWidget {
  final List<String> treatmentList;
  final ValueChanged<Treatment> onSave;

  const TreatmentDialog({
    super.key,
    required this.treatmentList,
    required this.onSave,
  });

  @override
  _TreatmentDialogState createState() => _TreatmentDialogState();
}

class _TreatmentDialogState extends State<TreatmentDialog> {
  String? selectedTreatment;
  int maleCount = 0;
  int femaleCount = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Choose Treatment'),
              TextFieldWithDropDown(
                options: widget.treatmentList,
                hintText: 'Choose preferred treatment',
                onChanged: (value) {
                  setState(() {
                    selectedTreatment = value;
                  });
                },
              ),
              SizedBoxes.normalSizedBox,
              const Text('Add Patients'),
              GenderCounterWidget(
                onMaleCountChanged: (count) {
                  setState(() {
                    maleCount = count;
                  });
                },
                onFemaleCountChanged: (count) {
                  setState(() {
                    femaleCount = count;
                  });
                },
              ),
              SizedBoxes.largeSizedBox,
              CommonButton(
                buttonText: 'Save',
                onPressed: () {
                  if (selectedTreatment != null) {
                    final treatment = Treatment(
                      type: selectedTreatment!,
                      malePatients: maleCount,
                      femalePatients: femaleCount,
                    );
                    widget.onSave(treatment);
                    Navigator.of(context).pop();
                  }
                },
              ),
              SizedBoxes.largeSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
