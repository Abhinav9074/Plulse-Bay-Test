import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        color: Color.fromARGB(245, 202, 211, 219),
        borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(200, 80),bottomRight: Radius.elliptical(300, 120))
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: (){
            Scaffold.of(context).openDrawer();
          }, icon:  Image.asset('assets/logo/menu.png',width: 30,)),
          Image.asset('assets/logo/logo.png',width: 150),
          const SizedBox(width: 40,height: 30,),
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size(double.maxFinite, 150);
}