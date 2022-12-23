// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/widgets/my_button.dart';
import 'package:email_validator/email_validator.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String screenRoute = 'forget_pw';
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailController =TextEditingController();

  @override 
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
  try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
    showDialog(context: context, builder: (context){
      return const AlertDialog(
        content: Text('Password reset link sent successfully! Check your email.'),
      );
    });

  } on FirebaseAuthException catch(e) {
    print(e);
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text(e.message.toString()),
      );
    });
  }

  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF455D83),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 300,
              child: Image.asset('assets/images/logo.png'),
            ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            'Enter your Email and we will send you a password reset link',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),
        ),

        const SizedBox(height: 10,),

          const SizedBox(height: 10,),
          TextFormField(
            controller: _emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction. done,
            decoration: InputDecoration(labelText: 'Email'),
            autovalidateMode:AutovalidateMode.onUserInteraction,
            validator: (email) =>
              email != null && !EmailValidator. validate(email)
                  ? 'Enter a valid email'
                      : null,
            ),

         MyButton(
              color: const Color(0xFF455D83),
              title: 'Reset Password',
              onPressed: passwordReset,
            )
      ],
      ),
    ),
    );
  }

 
}

