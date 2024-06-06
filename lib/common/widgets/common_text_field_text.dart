import 'package:flutter/cupertino.dart';

class CommonTextFieldText extends StatelessWidget {
  final String text;
  const CommonTextFieldText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w400),),
    );
  }
}
