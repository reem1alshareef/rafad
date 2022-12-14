import 'package:flutter/material.dart';
import 'package:rafad1/widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
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
                  height: 180,
                  child: Image.asset('assets/images/logoRafad.png'),
                ),
                const Text(
                  'MessageMe',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 35, 112, 138),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            MyButton(
              color: Color.fromARGB(255, 21, 134, 169)!,
              title: 'pilgrim',
              onPressed: () {},
            ),
            MyButton(
              color: Color.fromARGB(255, 21, 134, 169)!,
              title: 'campaign',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
