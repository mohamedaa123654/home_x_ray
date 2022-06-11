import 'package:flutter/material.dart';

import '../../modules/login_screen/login_screen.dart';
import '../components/components.dart';
import '../network/local/cache_helper.dart';

class AppConstants {
  static const int splashDelay = 2;
  static const int sliderAnimationTime = 300;
  static const String empty = "";
  static const int zero = 0;
}

bool? onBoarding;
bool? logined;

String? token = '';
String? uId = '';
Widget? widget;
double? latitude = 0;
double? longitude = 0;
void signOut(context) {
  uId = '';
  CacheHelper.removeData(
    key: 'uId',
  ).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
