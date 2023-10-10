import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappme/feature/auth/controller/authController.dart';
import 'package:whatsappme/feature/auth/widget/custom_textField.dart';
import 'package:whatsappme/common/helper/show_alert_dialog.dart';
import 'package:whatsappme/common/utils/appColors.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';
import 'package:whatsappme/common/widget/custom_elevated_buttom.dart';

import '../../../common/widget/custom_icon_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  showCountryCodePicker() {
    showCountryPicker(
        context: context,
        showPhoneCode: true,
        favorite: ['IN'],
        countryListTheme: CountryListThemeData(
          bottomSheetHeight: 600,
          backgroundColor: Theme.of(context).backgroundColor,
          flagSize: 22,
          borderRadius: BorderRadius.circular(20),
          textStyle: TextStyle(color: context.theme.greyColor),
          inputDecoration: InputDecoration(
              labelStyle: TextStyle(color: context.theme.greyColor),
              prefixIcon: const Icon(
                Icons.language,
                color: AppColors.greenDark,
              ),
              hintText: "Search country code or name",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: context.theme.greyColor!.withOpacity(0.2)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.greenDark),
              )),
        ),
        onSelect: (country) {
          countryNameController.text = country.name;
          countryCodeController.text = country.phoneCode;
        });
  }

  @override
  void initState() {
    countryNameController = TextEditingController(text: "India");
    countryCodeController = TextEditingController(text: "91");
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  sendCodeToPhone() {
    final phoneNumber = phoneNumberController.text;
    final countryName = countryNameController.text;
    final countryCode = countryCodeController.text;
    if (phoneNumber.isEmpty) {
      showAlertDialog(context: context, message: "Please enter your number");
    }

    if (phoneNumber.length < 9) {
      showAlertDialog(
          context: context,
          message:
              "The phone number you entered is too short for the country: $countryName.\n\n Include your area code if you haven't");
    } else if (phoneNumber.length > 10) {
      showAlertDialog(
          context: context,
          message:
              "The phone number you entered is too long for the country: $countryName");
    }

    // request a verification code
    ref
        .read(authControllerProvider)
        .sendCode(context: context, phoneNumber: '+$countryCode$phoneNumber');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            "Enter your phone number",
            style: TextStyle(color: context.theme.authAppBarTextColor),
          ),
          actions: [
            CustomIconButton(
              onTap: () {},
              icon: Icons.more_vert,
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RichText(
                  text: TextSpan(
                      text: "WhatsApp will need to verify your phone number ",
                      style: TextStyle(
                        color: context.theme.greyColor,
                        height: 1.5,
                      ),
                      children: [
                    TextSpan(
                        text: "What's my number?",
                        style: TextStyle(color: context.theme.blueColor))
                  ])),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomTextField(
                controller: countryNameController,
                onTap: showCountryCodePicker,
                readyOnly: true,
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.greenDark,
                ),
                keyboardType: null,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: CustomTextField(
                      keyboardType: null,
                      onTap: showCountryCodePicker,
                      controller: countryCodeController,
                      prefixText: '+',
                      readyOnly: true,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
                      onTap: () {},
                      controller: phoneNumberController,
                      textAlign: TextAlign.left,
                      hintText: 'phone number',
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Carrier changes may apply",
              style: TextStyle(color: context.theme.greyColor),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomElevatedButton(
          onPressed: sendCodeToPhone,
          buttonWidth: 90,
          text: "NEXT",
        ));
  }
}
