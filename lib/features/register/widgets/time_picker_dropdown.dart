import 'package:flutter/material.dart';
import '../../../common/theme/app_palatte.dart';

class TimePickerDropdown extends StatefulWidget {
  final ValueChanged<String?>? onHourChanged;
  final ValueChanged<String?>? onMinuteChanged;

  const TimePickerDropdown({
    super.key,
    this.onHourChanged,
    this.onMinuteChanged,
  });

  @override
  _TimePickerDropdownState createState() => _TimePickerDropdownState();
}

class _TimePickerDropdownState extends State<TimePickerDropdown> {
  String? _selectedHour;
  String? _selectedMinute;

  final List<String> hours =
  List<String>.generate(24, (int index) => index.toString().padLeft(2, '0'));
  final List<String> minutes =
  List<String>.generate(60, (int index) => index.toString().padLeft(2, '0'));


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppPalette.appColor,
            ),
            value: _selectedHour,
            onChanged: (String? newValue) {
              setState(() {
                _selectedHour = newValue;
              });
              if (widget.onHourChanged != null) {
                widget.onHourChanged!(newValue);
              }
            },
            decoration: const InputDecoration(
              hintText: 'Hour',
            ),
            items: hours
                .map((String option) => DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            ))
                .toList(),
            validator: (value){
              if(value == null){
                return 'Please select Hour';
              }else {
                return null;
              }
            },
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: DropdownButtonFormField<String>(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppPalette.appColor,
            ),
            value: _selectedMinute,
            onChanged: (String? newValue) {
              setState(() {
                _selectedMinute = newValue;
              });
              if (widget.onMinuteChanged != null) {
                widget.onMinuteChanged!(newValue);
              }
            },
            decoration: const InputDecoration(
              hintText: 'Minute',
            ),
            items: minutes
                .map((String option) => DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            ))
                .toList(),
            validator: (value){
              if(value == null){
                return 'Please select Minute';
              }else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }
}
