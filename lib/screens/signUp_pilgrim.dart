//import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:';هنا لازم احط صفحة ريم لوق اوت بعد ماتسوي التعريف

class SignUpPilgrim extends StatefulWidget {
  static const String screenRoute = 'signUP_pilgrim';
  const SignUpPilgrim({super.key});

  @override
  State<SignUpPilgrim> createState() => _SignUpPilgrimState();
}

class _SignUpPilgrimState extends State<SignUpPilgrim> {
  final _auth = FirebaseAuth.instance;
  late String name;
  late String phoneNumber;
  late String email;
  late String hajPermission;
  late String chronicDisease;
  late String pharmaceutical;
  late String password;
//هذي عشان نخزن البيانات فيها

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
            SizedBox(
              height: 180,
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(height: 50),
            TextFormField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                name = value; //هنا الفاليو اذا دخل الاسم بينحفظ
              },
              decoration: InputDecoration(
                labelText: 'pilgrim name',
                hintText: 'your full name',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF7D8DBA), //color: Colors.blue,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                phoneNumber = value;
              },
              decoration: InputDecoration(
                hintText: 'your phone number',
                labelText: 'phone number',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF7D8DBA),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                hintText: 'your Email',
                labelText: 'email',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF7D8DBA),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                hajPermission = value;
              },
              decoration: InputDecoration(
                hintText: 'your haj permission ID',
                labelText: 'haj permission ID',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF7D8DBA),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                chronicDisease = value;
              },
              decoration: InputDecoration(
                hintText: 'if you suffer from any chronic disease',
                labelText: 'chronic disease',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF7D8DBA),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                pharmaceutical = value;
              },
              decoration: InputDecoration(
                hintText: 'if you are taking any pharmaceutical',
                labelText: 'pharmaceutical',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF7D8DBA),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                hintText: 'your password',
                labelText: 'password',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF7D8DBA),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              /*  validator: (textValue) {
                if (textValue == null || textValue.isEmpty) {
                  return 'Password is required!';
                }
                return null;
              },*/
            ),
            SizedBox(height: 10),
            MyButton(
              color: const Color(0xFF455D83),
              title: 'register',
              onPressed: () async {
                //اجرب احط هنا كود الفاليديتر

                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      //اويت عشان يشيك هل الاميل والباس موجوده ؟ عشان يقدر يكمل تعبئة بيانات
                      email: email,
                      password:
                          password); //يرجع لي في السمتقبل هل هو موجود الايميل او لا
                  //  Navigator.pushNamed(context, logOutPilgrim.screenRoute); لازم ملف ريم موجود + تسوي التعريف في صفحتها
                } catch (e) {
                  print(e);
                }
                /* print(name); //طباعة عشان اتاكد من الكونسول هل فعلا حفظها او لا
                print(phoneNumber);
                print(email);
                print(hajPermission);
                print(chronicDisease);
                print(pharmaceutical);
                print(password);*/
              },
            )
          ],
        ),
      ),
    );
  }
}
