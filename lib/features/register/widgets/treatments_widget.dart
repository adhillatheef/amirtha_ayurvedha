import 'package:amirtha_ayurvedha/common/theme/app_palatte.dart';
import 'package:flutter/material.dart';
import 'package:amirtha_ayurvedha/features/register/data/model/treatment_model.dart';
import '../../../common/theme/themes.dart';

class TreatmentsWidget extends StatelessWidget {
  final Treatment treatment;

  const TreatmentsWidget({
    super.key,
    required this.treatment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: AppTheme.borderDecoration,
      child: Column(
        children: [
          ListTile(
            title: Text(
              treatment.type,
              style: const TextStyle(fontWeight: FontWeight.w500),
              softWrap: true,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/close.png'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPatientCountRow('Male', treatment.malePatients),
              _buildPatientCountRow('Female', treatment.femalePatients),
              IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icons/edit.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCountRow(String gender, int patientCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(gender,style: const  TextStyle(color: AppPalette.appColor),),
        _buildCountContainer(patientCount),

      ],
    );
  }

  Widget _buildCountContainer(int count) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: AppTheme.borderDecoration,
      child: Text(count.toString(), style: const  TextStyle(color: AppPalette.appColor),),
    );
  }
}
