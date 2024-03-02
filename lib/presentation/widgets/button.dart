import 'package:flutter/material.dart';
import 'package:pulse_bay/presentation/config/text_styles.dart';

class CommonButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const CommonButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 4, 134, 204)),
          padding: const MaterialStatePropertyAll(EdgeInsets.fromLTRB(145, 0, 145, 0))
        ), 
        child: Text(text,style: MyTextStyle.buttonTextWhite,),
        ),
    );
  }
}