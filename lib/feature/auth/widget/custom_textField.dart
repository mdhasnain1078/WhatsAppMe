import 'package:flutter/material.dart';
import 'package:whatsappme/common/utils/appColors.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.readyOnly,
      this.textAlign,
      required this.keyboardType,
      this.prefixText,
      this.onTap,
      this.suffixIcon,
      this.onChanged, this.fontSize, this.autofocus});

  final TextEditingController? controller;
  final String? hintText;
  final bool? readyOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? prefixText;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final double? fontSize;
  final bool ? autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.greenDark,
      onTap: onTap,
      controller: controller,
      readOnly: readyOnly?? false,
      textAlign: textAlign?? TextAlign.center,
      keyboardType: readyOnly == null ? keyboardType : null,
      onChanged: onChanged,
      autofocus: autofocus ?? false,
      style: TextStyle(fontSize: fontSize),
      decoration: InputDecoration(
        isDense: true,
        prefixText: prefixText,
        suffix: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(color: context.theme.greyColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.greenDark)
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.greenDark, width: 2)
        )
      ),
    );
  }
}
