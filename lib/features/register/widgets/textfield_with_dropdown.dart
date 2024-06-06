import 'package:amirtha_ayurvedha/common/theme/app_palatte.dart';
import 'package:flutter/material.dart';

class TextFieldWithDropDown extends StatefulWidget {
  final List<String> options;
  final String? value;
  final String hintText;
  final ValueChanged<String?>? onChanged;

  const TextFieldWithDropDown({
    super.key,
    required this.options,
    this.value,
    required this.hintText,
    this.onChanged,
  });

  @override
  State<TextFieldWithDropDown> createState() => _TextFieldWithDropDownState();
}

class _TextFieldWithDropDownState extends State<TextFieldWithDropDown> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: const Icon(Icons.keyboard_arrow_down, color: AppPalette.appColor,),
      value: _selectedValue,
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
      items: widget.options
          .map((String option) => DropdownMenuItem<String>(
        value: option,
        child: Text(option),
      ))
          .toList(),
    );
  }
}
