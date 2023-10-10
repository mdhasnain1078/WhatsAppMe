import 'package:flutter/material.dart';

import '../utils/appColors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key, this.text, required this.onPressed, required this.buttonWidth,
  });
  final String ? text;
  final VoidCallback onPressed;
  final double? buttonWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 42,
    width:buttonWidth?? MediaQuery.of(context).size.width -100,
    child: ElevatedButton(style: ElevatedButton.styleFrom(
    ) , onPressed: onPressed,
    child: Text(text??"AGREE AND CONTINUE"),),);
  }
}