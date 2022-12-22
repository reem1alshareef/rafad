import 'package:flutter/material.dart';
import 'package:rafad1/screens/signUP_pilgrim.dart'; //سويت امبورت عشان الربط مع البتن
import 'package:rafad1/screens/signUp_campaign.dart'; // same
import 'package:rafad1/widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'welcome_screen'; // للربط بين الصفحات
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 300,
                  child: Image.asset('assets/images/logo.png'),
                ),
                const Text(
                  'Welcome !',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF788AA4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            MyButton(
              color: const Color(0xFF455D83),
              title: 'Pilgrim',
              onPressed: () {
                Navigator.pushNamed(context, SignUpPilgrim.screenRoute);
              },
            ),
            MyButton(
              color: const Color(0xFF455D83),
              title: 'Campaign',
              onPressed: () {
                Navigator.pushNamed(context, SignUpCampaign.screenRoute);
              },
            ),
            Row(
              children: <Widget>[
                const Text('Already a member?'),
                TextButton(
                  child: const Text('log in',
                      //style: TextStyle(fontSize: 20),
                      style: TextStyle(
                        decoration:
                            TextDecoration.underline, //اضافة شادن عشان الخط
                        fontSize: 20,
                      )),
                  onPressed: () {
                    //هنا ربط مع صفحة شادن
                    //Navigator.pushNamed(context, log in screen.screenRoute);
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
