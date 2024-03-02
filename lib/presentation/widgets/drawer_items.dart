import 'package:flutter/material.dart';
import 'package:pulse_bay/domain/api/api_services.dart';
import 'package:pulse_bay/domain/functions/shared_preference.dart';
import 'package:pulse_bay/presentation/config/text_styles.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset('assets/logo/no_image.png'),
              Text(
                'Hi, ${SharedPreferenceFunction().sharedInstance.getString('UserName')}',
                style: MyTextStyle.normalTextBlue,
              ),
            ],
          ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                    leading: Image.asset('assets/logo/icon1.png'),
                    title: const Text(
                      'Dashboard',
                      style: MyTextStyle.headingSmall,
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Divider(),
              ),
              ExpansionTile(
                
                title: ListTile(
                    leading: Image.asset('assets/logo/icon2.png'),
                    title: const Text(
                      'My Account',
                      style: MyTextStyle.headingSmall,
                    )),
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Icon(Icons.radio_button_checked),
                        Text(
                          'Edit Account',
                          style: MyTextStyle.headingSmall,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Icon(Icons.radio_button_checked),
                        Text(
                          'Change Password',
                          style: MyTextStyle.headingSmall,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                    leading: Image.asset('assets/logo/icon3.png'),
                    title: const Text(
                      'Chat',
                      style: MyTextStyle.headingSmall,
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                    leading: Image.asset('assets/logo/icon4.png'),
                    title: const Text(
                      'My Jobs',
                      style: MyTextStyle.headingSmall,
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                    leading: Image.asset('assets/logo/icon5.png'),
                    title: const Text(
                      'Notification',
                      style: MyTextStyle.headingSmall,
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                    leading: Image.asset('assets/logo/icon6.png'),
                    title: const Text(
                      'Contact Us',
                      style: MyTextStyle.headingSmall,
                    )),
              )
            ],
          ),

          //Logout Button

          TextButton.icon(
              onPressed: () async{
                await ApiServices.logOut();
                SharedPreferenceFunction().sharedInstance.clear();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              label: const Text(
                'LogOut',
                style: MyTextStyle.headingSmall,
              ))
        ],
      ),
    );
  }
}
