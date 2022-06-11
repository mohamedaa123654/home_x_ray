import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData lightTheme = ThemeData(
  // main colors
  scaffoldBackgroundColor: ColorManager.white,
  primarySwatch: ColorManager.white as MaterialColor?,
  primaryColor: ColorManager.primary,
  primaryColorLight: ColorManager.lightPrimary,
  primaryColorDark: ColorManager.darkPrimary,

  disabledColor: ColorManager.white,
  splashColor: ColorManager.lightPrimary,
  // ripple effect color
  // cardview theme
  cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4),
  // app bar theme
  appBarTheme: AppBarTheme(
    // centerTitle: true,
    color: ColorManager.backgroundColor,
    elevation: AppSize.s0,
    shadowColor: ColorManager.lightPrimary,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: ColorManager.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: getRegularStyle(
      fontSize: FontSize.s14,
      color: ColorManager.black,
    ),
    iconTheme: IconThemeData(color: ColorManager.black),
  ),
  backgroundColor: Colors.white,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: ColorManager.primary,
  ),
//bottom Navigation Bar Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: ColorManager.grey),
  // button theme
  buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary),

  // elevated button them
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s17),
          primary: ColorManager.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12)))),

  // input decoration theme (text form field)
  inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      // hint style
      hintStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      labelStyle:
          getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManager.error),

      // enabled border style
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      // focused border style
      focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      // error border style
      errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.error, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      // focused border style
      focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))),
  // label style
);

ThemeData darkMode = ThemeData(
  // primarySwatch: ColorManager.primary as MaterialColor?,
  scaffoldBackgroundColor: ColorManager.backgroundColor,
  appBarTheme: AppBarTheme(
    // centerTitle: true,
    // color: ColorManager.backgroundColor,
    titleSpacing: 20.0,
    backwardsCompatibility: false,

    // systemOverlayStyle: SystemUiOverlayStyle(
    //   statusBarColor: ColorManager.darkGrey,
    //   statusBarIconBrightness: Brightness.light,
    // ),
    backgroundColor: ColorManager.backgroundColor,
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: ColorManager.primary,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: ColorManager.primary,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: ColorManager.darkGrey,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);
