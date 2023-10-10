import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whatsappme/common/utils/appColors.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    backgroundColor: AppColors.backgroundDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    extensions: [CustomThemeExtension.darkMode],
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.greyBackGround,
        titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.greyDark),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light)),
    iconTheme: const IconThemeData(color: AppColors.greyDark),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.greenDark,
            foregroundColor: AppColors.blackButton,
            splashFactory: NoSplash.splashFactory,
            elevation: 0,
            shadowColor: Colors.transparent)),
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2, color: AppColors.greenDark),
      ),
      unselectedLabelColor: AppColors.greyDark,
      labelColor: AppColors.greenDark,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.greyBackGround,
        modalBackgroundColor: AppColors.greyBackGround,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
    dialogBackgroundColor: AppColors.greyBackGround,
    dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    )),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.greenDark, foregroundColor: AppColors.white),
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.greyDark,
      tileColor: AppColors.backgroundDark,
    ),
    switchTheme: const SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(AppColors.greyDark),
      trackColor: MaterialStatePropertyAll(Color(0xFF344047)),
    ),
  );
}
