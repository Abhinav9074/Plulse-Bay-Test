// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_bay/application/home_bloc/home_bloc.dart';
import 'package:pulse_bay/application/home_bloc/home_event.dart';
import 'package:pulse_bay/application/login_bloc/login_bloc.dart';
import 'package:pulse_bay/application/login_bloc/login_event.dart';
import 'package:pulse_bay/application/login_bloc/login_state.dart';
import 'package:pulse_bay/application/region_bloc/region_bloc.dart';
import 'package:pulse_bay/application/region_bloc/region_event.dart';
import 'package:pulse_bay/application/tradie_bloc/tradie_event.dart';
import 'package:pulse_bay/application/tradie_bloc/traide_bloc.dart';
import 'package:pulse_bay/presentation/config/snackbar.dart';
import 'package:pulse_bay/presentation/config/text_styles.dart';
import 'package:pulse_bay/presentation/widgets/button.dart';
import 'package:pulse_bay/presentation/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(245, 245, 245, 245),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_container1(context), _container2(context)],
          ),
        ));
  }

  //Main container 1
  Widget _container1(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.45,
      child: Center(
        child: Image.asset('assets/logo/logo.png'),
      ),
    );
  }

  //Main container 2
  Widget _container2(BuildContext context) {
    return PhysicalModel(
      color: Colors.black,
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Welcome heading
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 0, 10),
              child: Text(
                'Welcome',
                style: MyTextStyle.headingTextBlue,
              ),
            ),

            //welcome text
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
              child: Text(
                'Hello there, Sign in to continue!',
                style: MyTextStyle.smallText,
              ),
            ),

            //divider
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(),
            ),
            //text filelds
            _textFields(),

            //forgot button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password',
                        style: MyTextStyle.smallText,
                      ))
                ],
              ),
            ),

            //button
             BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if(state is LoginFailedState){
                  AllSnackBars.commonSnackbar(context: context, title: 'Invalid Credentials', content: 'Invalid Credentials', bg: Colors.red);
                }else if(state is LoginSuccessState){
                  BlocProvider.of<HomeBloc>(context).add(HomeDataFetchEvent());
                  BlocProvider.of<RegionBloc>(context).add(RegionFetchEvent());
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  AllSnackBars.commonSnackbar(context: context, title: 'Login Success', content: 'Login Success', bg: Colors.green);
                }
              },
              builder: (context, state) {
                if(state is LoginLoadingState){
                  return const Center(child: CupertinoActivityIndicator());
                }else{
                  return  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonButton(text: 'Login',onPressed: (){BlocProvider.of<LoginBloc>(context).add(LoggedInEvent(password: passwordCont.text, email: emailCont.text));},),
                  ],
                );
                }
              },
            ),

            //Register
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '''Don't Have An Account?''',
                  style: MyTextStyle.smallText,
                ),
                Text(
                  'Register!',
                  style: MyTextStyle.smallTextBold,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //Textform fields
  Widget _textFields() {
    return Column(
      children: [
        CommonTextField(
            textCont: emailCont,
            hint: 'Enter Email Address',
            heading: 'Email Address',
            obscure: false),
        CommonTextField(
            textCont: passwordCont,
            hint: 'Enter Password',
            heading: 'Password',
            obscure: true)
      ],
    );
  }
}
