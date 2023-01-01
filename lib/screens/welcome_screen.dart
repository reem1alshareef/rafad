import 'package:flutter/material.dart';
import 'package:rafad1/screens/signUP_pilgrim.dart';
import 'package:rafad1/screens/signUp_campaign.dart';
import 'package:rafad1/widgets/my_button.dart';
import 'package:rafad1/screens/LoginPage.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'welcome_screen';
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
///////////////////////////////////////////////////////////////////////
                Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assests/images/background.png"),
                  fit: BoxFit.cover)),),
/////////////////////////////////////////////////////////////////////
                SizedBox(
                  height: 300,
                  child: Image.asset('assests/images/logo.png'),
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
              title: 'Sign up As Pilgrim',
              onPressed: () {
                Navigator.pushNamed(context, SignUpPilgrim.screenRoute);
              },
            ),
            MyButton(
              color: const Color(0xFF455D83),
              title: 'Sign up As Campaign',
              onPressed: () {
                Navigator.pushNamed(context, SignUpCampaign.screenRoute);
              },
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account ? ',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff939393),
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()))
                    },
                    child: const Text(
                      'Log-in',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
