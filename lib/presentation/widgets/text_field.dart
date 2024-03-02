import 'package:flutter/material.dart';
import 'package:pulse_bay/presentation/config/text_styles.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController textCont;
  final String hint;
  final String heading;
  final bool obscure;

  const CommonTextField({super.key, required this.textCont, required this.hint, required this.heading, required this.obscure});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(heading,style: MyTextStyle.headingSmall,),
          const SizedBox(height: 10),
          TextFormField(
            obscureText: obscure,
            controller: textCont,
            decoration: InputDecoration(
              hintStyle: MyTextStyle.hintText,
              hintText: hint,
              contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
          )
        ],
      ),
    );
  }
}