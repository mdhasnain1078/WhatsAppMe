import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappme/feature/auth/controller/authController.dart';
import 'package:whatsappme/feature/auth/widget/custom_textField.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';
import 'package:whatsappme/common/widget/custom_icon_button.dart';

class VarificationPage extends ConsumerWidget {
  const VarificationPage({super.key, required this.smsCodeId, required this.phoneNumber});
  final String smsCodeId;
  final String phoneNumber;

  void verfySmsCode(WidgetRef ref, BuildContext context, String smsCode){
    ref.read(authControllerProvider).verfySmsCode(context: context, smsCodeId: smsCodeId, smsCode: smsCode, mounted: true);

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'Verify your number',
          style: TextStyle(color: context.theme.authAppBarTextColor),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
            onTap: () {},
            icon: Icons.more_vert_outlined,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style:
                        TextStyle(color: context.theme.greyColor, height: 1.5),
                    children: [
                      const TextSpan(
                          text:
                              "You have tried to register +919315810327 before requisting an SMS or call with your code. "),
                      TextSpan(
                          text: "Wrong number?",
                          style: TextStyle(color: context.theme.blueColor))
                    ]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: CustomTextField(
                keyboardType: TextInputType.number,
                hintText: "- - -  - - -",
                fontSize: 30,
                autofocus: true,
                onChanged: (value){
                  if(value.length==6){
                    verfySmsCode(ref, context, value);
                  }
                },
              ),
            ),
           const SizedBox(height: 20,),
           Text("Enter 6 digit code", style: TextStyle(color: context.theme.greyColor),),
           const SizedBox(height: 30,),
           Row(children: [
            Icon(Icons.message, color: context.theme.greyColor,),
            const SizedBox(width: 20,),
            Text('Resend SMS', style: TextStyle(color: context.theme.greyColor),),
           ],),
           const SizedBox(height: 10,),
            Divider(color: context.theme.blueColor!.withOpacity(0.2),),
            const SizedBox(height: 10,),
           Row(children: [
            Icon(Icons.phone, color: context.theme.greyColor,),
            const SizedBox(width: 20,),
            Text('Call Me', style: TextStyle(color: context.theme.greyColor),),
            const SizedBox(height: 10,),
            Divider(color: context.theme.blueColor!.withOpacity(0.2),),
  
           ],)
          ],
        ),
      ),
    );
  }
}
