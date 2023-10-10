import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../extension/custom_theme_extention.dart';
import '../utils/appColors.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      backgroundColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.white,
      extensions: [CustomThemeExtension.lightMode],
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.greenLight,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
        )
      ),
      tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2, color: AppColors.white),
        ),
        unselectedLabelColor: Color(0xFFB3D9D2),
        labelColor: Colors.white
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.greenLight,
              foregroundColor: AppColors.white,
              splashFactory: NoSplash.splashFactory,
              elevation: 0,
              shadowColor: Colors.transparent)),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.white,
          modalBackgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
      dialogBackgroundColor: AppColors.white,
              dialogTheme: DialogTheme(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),)
            ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.greenDark, foregroundColor: AppColors.white),
      listTileTheme: const ListTileThemeData(
      iconColor: AppColors.greyDark,
      tileColor: AppColors.white,
    ),
    switchTheme: const SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(Color(0xFF83939C)),
      trackColor: MaterialStatePropertyAll(Color(0xFFDADFE2)),
    ),
      );
}
