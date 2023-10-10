import 'package:flutter/material.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';

import '../utils/appColors.dart';

class PrivecyAndTerms extends StatelessWidget {
  const PrivecyAndTerms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
        text: "Read our ",
        
        style: TextStyle(
          color: context.theme.greyColor,
          
        ),
        children: [
          TextSpan(text: "Privacy Policy ", style: TextStyle(
          color: context.theme.blueColor,
          
        ),),
          const TextSpan(text:'Tap "Agree And Continue" to accept the '),
          TextSpan(text: "Term of Services", style: TextStyle(
          color: context.theme.blueColor,
          
        ),)
        ]
      )),
    );
  }
}