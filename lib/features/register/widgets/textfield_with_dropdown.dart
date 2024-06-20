import 'package:flutter/material.dart';
import 'package:amirtha_ayurvedha/common/theme/app_palatte.dart';

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
  _TextFieldWithDropDownState createState() => _TextFieldWithDropDownState();
}

class _TextFieldWithDropDownState extends State<TextFieldWithDropDown> {
  String? _selectedValue;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  String? _validateDropDown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select an option';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down, color: AppPalette.appColor),
      value: _selectedValue,
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue;
          _hasError = false;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: _hasError ? _validateDropDown(_selectedValue) : null,
      ),
      selectedItemBuilder: (BuildContext context) {
        return widget.options.map<Widget>((String option) {
          return Text(
            option,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          );
        }).toList();
      },
      items: widget.options
          .map((String option) => DropdownMenuItem<String>(
        value: option,
        child: Text(option),
      ))
          .toList(),
      validator: _validateDropDown,
    );
  }
}
