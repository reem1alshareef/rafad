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

//شغل ليلى انحذف
class Report extends StatefulWidget {
  const Report({
    super.key,
    required this.campaignId,
    required this.campaignName,
  });

  final campaignId;
  final campaignName;

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  //final TextEditingController _Textcontroller = TextEditingController();
  String? tilte;
  String? problem;
  final _reportFormKey = GlobalKey<FormState>();

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
                  onChanged: (value) {
                    setState(() {
                      tilte = value;
                    });
                  },
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (textValue) {
                      if (textValue == null || textValue.isEmpty) {
                        return 'Problem can not be empty!';
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

                  // هنا مفروض يودي لمكان آخر بعدله مع ليلى
                  //اضفت هنا ارسال رسالة تأكيد
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      icon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      //تأكدي لو صح او لا
                      title: const Text("Report problem Successfully"),
                      content:
                          const Text("your report was successfully submitted"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            child: const Text("Ok"),
                          ),
                        ),
                      ],
                    ),
                  );
                  await FirebaseFirestore.instance
                      .collection("Problem-Report")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .set({
                    'tilte': tilte,
                    'problem': problem,
                    'UID': FirebaseAuth.instance.currentUser!.uid,
                    'CUID': widget.campaignId,
                    'Cname': widget.campaignName
                  });
                   }
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
