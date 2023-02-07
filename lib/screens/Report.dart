import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rafad1/screens/welcome_screen.dart';

import 'LoginPage.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  //final TextEditingController _Textcontroller = TextEditingController();
  String? tilte;
  String? problem;
  final _reportFormKey = GlobalKey<FormState>(); //اضفت هذا نشوف ل وش

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report A Problem"),
        backgroundColor: const Color(0xFF455D83),
        elevation: 0,
      ),

      // start here
      body: Center(
        child: Form(
          key: _reportFormKey,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, //ارجعي له في حال خرب علينا
            children: [
              const SizedBox(
                height: 16,
              ),
              Text("Title"),
              // : Text('Sent Message: ${_Textcontroller.value.text}'),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Enter the title of problem',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
              ),
              const SizedBox(
                height: 16,
              ),

              //بعد السايز بوكس نحط الفور يفلد بحط الباقي نوت
              Text("Enter the problem description"),
              // : Text('Sent Message: ${_Textcontroller.value.text}'),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    // controller: _Textcontroller,
                    minLines: 2,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                        RegExp(r"\s\s"),
                      )
                    ],
                    textInputAction: TextInputAction.done,
                    // keyboardType: TextInputType.text, هل له تأثير في  الفالديتير
                    onChanged: (value) {
                      setState(() {
                        problem = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter your problem here',
                        hintStyle: TextStyle(color: Colors.grey),
                        isDense: true, //اضفت هذي عشان الفالديتير
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (textValue) {
                      if (textValue == null || textValue.isEmpty) {
                        return 'Write the problem is required!';
                      }
                      return null;
                    }),
              ),
              const SizedBox(
                height: 16,
              ),

              CustomFormButton(
                innerText: 'Submit',
                onPressed: () async {
                  if (_reportFormKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WelcomeScreen())); //هنا مفروض يودي لمكان آخر بعدله مع ليلى
                    await FirebaseFirestore.instance
                        .collection("Problem-Campagin")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set({
                      'tilte': tilte,
                      'problem': problem,
                      'UID': FirebaseAuth.instance.currentUser!.uid,
                    });
                  }
                },
              ),

              /* ElevatedButton(
                onPressed: () {
                  // for pop up message
                  setState(() {
                    _Textcontroller.notifyListeners();
                  });
                },
                child: Text("Submit"),
              )*/
            ],
          ),
        ),
      ),
    );
  }

// كيف استدعيها عند زر الون برسد
  /* Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report Successful '),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('your report was successfully  submitted'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('GOT IT'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
*/
/*Future<bool> alertDialog( BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Done'),
          content: Text('Add Success'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
            
            ),
          ],
        );
      });*/
}
