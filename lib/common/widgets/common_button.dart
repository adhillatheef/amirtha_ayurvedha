import 'package:amirtha_ayurvedha/common/theme/app_palatte.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;

  const CommonButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.color = AppPalette.appColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Set the border radius here
        ),
        backgroundColor: color,
        shadowColor:Colors.transparent,
        fixedSize: const Size(395, 55),
      ),
      child: Text(
        buttonText,
        style:  TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
