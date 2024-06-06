import 'package:flutter/material.dart';

import 'common_text_field_text.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final String fieldText;
  final TextEditingController controller;
  final bool isPassword;
  final bool showHintText;
  final TextInputType? textInputType;

  const CommonTextField({
    super.key,
    required this.hintText,
    required this.fieldText,
    required this.controller,
    this.isPassword = false,
    this.showHintText = true,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextFieldText(text: fieldText,),
        TextFormField(
          keyboardType: textInputType,
          obscureText: isPassword,
            controller: controller,
            decoration: InputDecoration(
              hintText: showHintText? hintText : '',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "$fieldText is empty";
              }
              return null;
            },
        ),
      ],
    );
  }
}
