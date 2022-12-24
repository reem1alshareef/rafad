// ignore_for_file: camel_case_types, avoid_print, duplicate_ignore

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages, unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();


  @override 
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
    } on FirebaseAuthException catch(e){
      // ignore: avoid_print
      print(e);
      showDialog(context: context, builder: (context){
        return const AlertDialog(content: Text('Password reset link sent! Check your email'),
        );
        }
        );
    }
    
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
    } on FirebaseAuthException catch(e){
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(content: Text(e.message.toString()),
        );
        }
        );
    }


  }
   

  @override
  Widget build(BuildContext context) {
    return Container(
    constraints: const BoxConstraints.expand(),
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/background1.png"), fit: BoxFit.cover)),
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            'Enter Your Email and we will send you a password reset link',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),
        ),

        const SizedBox(height: 10,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'Email' ,
              fillColor: Colors.grey[200],
              filled: true,
              ),
            ),
          ),

          const SizedBox(height: 10,),

          MaterialButton(
            onPressed: passwordReset,
            color: Colors.blue,
            child: const Text('Reset Password'),
            ),
      ],
      ),
    ),
    );
  }
}



