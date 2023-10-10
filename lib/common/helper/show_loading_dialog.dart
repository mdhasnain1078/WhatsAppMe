import 'package:flutter/material.dart';
import 'package:whatsappme/common/utils/appColors.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';

showLoadingDialog(
    {required BuildContext context, required String message}) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const CircularProgressIndicator(color: AppColors.greenDark,),
                    const SizedBox(width: 20,),
                    Expanded(child: Text(message, style: TextStyle(color: context.theme.greyColor, height: 1.5, fontSize: 15),))
                  ],
                )
              ],
            )
          ));
}
