import 'package:flutter/material.dart';
import 'package:whatsappme/common/routes/routes.dart';
import 'package:whatsappme/common/utils/appColors.dart';
import 'package:whatsappme/constants/colors.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';

import '../../../common/widget/custom_elevated_buttom.dart';
import '../../../common/widget/language_button.dart';
import '../../../common/widget/privecy_and_terms.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  navigateToLoginPage(BuildContext context){
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Image.asset("assets/image/circle.png", color: context.theme.circleImageColor,),
                      ),
            )),
          const Expanded(child: SizedBox(),),
          Expanded(
            flex: 4 ,
            child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            const Text("Welcom To WhatsApp", style: TextStyle(fontSize: 22),),
            const PrivecyAndTerms(),
            CustomElevatedButton(onPressed: ()=>navigateToLoginPage(context), text: 'AGREE AND CONTINUE', buttonWidth: null,),
            const SizedBox(height: 50,),
            const LanguageButton()
          ],))
        ],),
      )
    );
  }
}
