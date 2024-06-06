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
          child: _buildDropdown(
            value: _selectedHour,
            items: hours,
            hint: 'Hour',
            onChanged: (String? newValue) {
              setState(() {
                _selectedHour = newValue;
              });
              if (widget.onHourChanged != null) {
                widget.onHourChanged!(newValue);
              }
            },
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: _buildDropdown(
            value: _selectedMinute,
            items: minutes,
            hint: 'Minutes',
            onChanged: (String? newValue) {
              setState(() {
                _selectedMinute = newValue;
              });
              if (widget.onMinuteChanged != null) {
                widget.onMinuteChanged!(newValue);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String hint,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: AppPalette.appColor,
      ),
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
      ),
      items: items
          .map((String option) => DropdownMenuItem<String>(
        value: option,
        child: Text(option),
      ))
          .toList(),
    );
  }
}
