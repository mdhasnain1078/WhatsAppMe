import 'package:flutter/material.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';

showAlertDialog(
    {required BuildContext context, required String message, String? btnText}) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text(
              message,
              style: TextStyle(color: context.theme.greyColor, fontSize: 15),
            ),
            contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            actions: [
              TextButton(
                onPressed: ()=> Navigator.of(context).pop(),
                child: Text(
                  btnText ?? "Ok",
                  style: TextStyle(color: context.theme.circleImageColor),
                ),
              )
            ],
          ));
}
