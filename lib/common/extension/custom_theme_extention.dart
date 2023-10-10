import 'package:flutter/material.dart';
import 'package:whatsappme/common/utils/appColors.dart';

extension ExtendedTheme on BuildContext {
  CustomThemeExtension get theme =>
      Theme.of(this).extension<CustomThemeExtension>()!;
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  static const lightMode = CustomThemeExtension(
      authAppBarTextColor: AppColors.greenDark,
      circleImageColor: Color(0xFF25D366),
      greyColor: AppColors.greyLight,
      blueColor: AppColors.blueLight,
      langBtnBgColor: Color(0xFFF7F8FA),
      langBtnHighLightColor: Color(0xFFE8E8ED),
      photoIconBgColor: Color(0xFFF0F2F3),
      photoIconColor: Color(0xFF9DAAB3),
      profilePageBg: Color(0xFFF7F8FA),
    chatTextFieldBg: Colors.white,
    chatPageBgColor: Color(0xFFEFE7DE),
    chatPageDoodleColor: Colors.white70,
    senderChatCardBg: Color(0xFFE7FFDB),
    receiverChatCardBg: Color(0xFFFFFFFF),
    yellowCardBgColor: Color(0xFFFFEECC),
    yellowCardTextColor: Color(0xFF13191C),);

  static const darkMode = CustomThemeExtension(
      authAppBarTextColor: AppColors.white,
      circleImageColor: AppColors.greenDark,
      greyColor: AppColors.greyDark,
      blueColor: AppColors.blueDark,
      langBtnBgColor: Color(0xFF182229),
      langBtnHighLightColor: Color(0xFF09141A),
      photoIconBgColor: Color(0xFF283339),
      photoIconColor: Color(0xFF61717B),
    profilePageBg: Color(0xFF0B141A),
    chatTextFieldBg: AppColors.greyBackGround,
    chatPageBgColor: Color(0xFF081419),
    chatPageDoodleColor: Color(0xFF172428),
    senderChatCardBg: Color(0xFF005C4B),
    receiverChatCardBg: AppColors.greyBackGround,
    yellowCardBgColor: Color(0xFF222E35),
    yellowCardTextColor: Color(0xFFFFD279),);

  final Color? circleImageColor;
  final Color? greyColor;
  final Color? blueColor;
  final Color? langBtnBgColor;
  final Color? langBtnHighLightColor;
  final Color? authAppBarTextColor;
  final Color? photoIconBgColor;
  final Color? photoIconColor;
  final Color? profilePageBg;
  final Color? chatTextFieldBg;
  final Color? chatPageBgColor;
  final Color? chatPageDoodleColor;
  final Color? senderChatCardBg;
  final Color? receiverChatCardBg;
  final Color? yellowCardBgColor;
  final Color? yellowCardTextColor;

  const CustomThemeExtension({
      this.profilePageBg,
      this.chatTextFieldBg,
      this.chatPageBgColor,
      this.chatPageDoodleColor,
      this.senderChatCardBg,
      this.receiverChatCardBg,
      this.yellowCardBgColor,
      this.yellowCardTextColor,
      this.photoIconBgColor,
      this.photoIconColor,
      this.authAppBarTextColor,
      this.circleImageColor,
      this.greyColor,
      this.blueColor,
      this.langBtnBgColor,
      this.langBtnHighLightColor,}
      );

  @override
  ThemeExtension<CustomThemeExtension> copyWith(
      {Color? circleImageColor,
      Color? greyColor,
      Color? blueColor,
      Color? langBtnBgColor,
      Color? langBtnHighLightColor,
      Color? authAppBarTextColor,
      Color? photoIconBgColor,
      Color? photoIconColor,
     Color? profilePageBg,
    Color? chatTextFieldBg,
    Color? chatPageBgColor,
    Color? chatPageDoodleColor,
    Color? senderChatCardBg,
    Color? receiverChatCardBg,
    Color? yellowCardBgColor,
    Color? yellowCardTextColor,}) {
    return CustomThemeExtension(
        authAppBarTextColor: authAppBarTextColor ?? this.authAppBarTextColor,
        circleImageColor: circleImageColor ?? this.circleImageColor,
        blueColor: blueColor ?? this.blueColor,
        langBtnBgColor: langBtnBgColor ?? this.langBtnBgColor,
        langBtnHighLightColor:
            langBtnHighLightColor ?? this.langBtnHighLightColor,
        greyColor: greyColor ?? this.greyColor,
        photoIconBgColor: photoIconBgColor ?? this.photoIconBgColor,
        photoIconColor: photoIconColor ?? this.photoIconColor,
      profilePageBg: profilePageBg ?? this.profilePageBg,
      chatTextFieldBg: chatTextFieldBg ?? this.chatTextFieldBg,
      chatPageBgColor: chatPageBgColor ?? this.chatPageBgColor,
      chatPageDoodleColor: chatPageDoodleColor ?? this.chatPageDoodleColor,
      senderChatCardBg: senderChatCardBg ?? this.senderChatCardBg,
      receiverChatCardBg: receiverChatCardBg ?? this.receiverChatCardBg,
      yellowCardBgColor: yellowCardBgColor ?? this.yellowCardBgColor,
      yellowCardTextColor: yellowCardTextColor ?? this.yellowCardTextColor,);
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
      covariant ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) return this;
    return CustomThemeExtension(
      authAppBarTextColor:
          Color.lerp(authAppBarTextColor, other.authAppBarTextColor, t),
      circleImageColor: Color.lerp(circleImageColor, other.circleImageColor, t),
      blueColor: Color.lerp(blueColor, other.blueColor, t),
      langBtnBgColor: Color.lerp(langBtnBgColor, other.langBtnBgColor, t),
      langBtnHighLightColor:
          Color.lerp(langBtnHighLightColor, other.langBtnHighLightColor, t),
      greyColor: Color.lerp(greyColor, other.greyColor, t),
      photoIconBgColor: Color.lerp(photoIconBgColor, other.photoIconBgColor, t),
      photoIconColor: Color.lerp(photoIconColor, other.photoIconColor, t),
      profilePageBg: Color.lerp(profilePageBg, other.profilePageBg, t),
      chatTextFieldBg: Color.lerp(chatTextFieldBg, other.chatTextFieldBg, t),
      chatPageBgColor: Color.lerp(chatPageBgColor, other.chatPageBgColor, t),
      senderChatCardBg: Color.lerp(senderChatCardBg, other.senderChatCardBg, t),
      yellowCardBgColor:
          Color.lerp(yellowCardBgColor, other.yellowCardBgColor, t),
      yellowCardTextColor:
          Color.lerp(yellowCardTextColor, other.yellowCardTextColor, t),
      receiverChatCardBg:
          Color.lerp(receiverChatCardBg, other.receiverChatCardBg, t),
      chatPageDoodleColor:
          Color.lerp(chatPageDoodleColor, other.chatPageDoodleColor, t),
    );
  }
}
