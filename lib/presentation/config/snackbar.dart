
import 'package:flutter/material.dart';
import 'package:pulse_bay/presentation/config/text_styles.dart';

class AllSnackBars {
  static void commonSnackbar({required BuildContext context,required String title,required String content,required Color bg}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        content,
        textScaler: TextScaler.noScaling,
        style: MyTextStyle.snacknbarText,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: bg,
    ));
  }
}
