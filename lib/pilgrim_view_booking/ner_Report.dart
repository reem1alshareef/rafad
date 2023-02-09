/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:rafad1/screens/LoginPage.dart';
//import 'package:rafad1/screens/Report.dart';

import '../screens/welcome_screen.dart';
import '../widgets/my_button.dart';

class Report extends StatefulWidget {
  const Report({
    Key? key,
    required this.campaignId,
    required this.campaignName,
  }) : super(key: key);

  final campaignId;
  final campaignName;

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final _firestore = FirebaseFirestore.instance;
  double rating = 0;
  String? review;
  final _review = GlobalKey<FormState>();
  bool isButtonDisabled = false;
  String? tilte;
  String? problem;
  final _reportFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection("Pilgrims-Account")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("pilgrimCampaigns")
        .where('bookStatus', isEqualTo: 'Confirmed')
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: Text("Report A Problem"),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: StreamBuilder<QuerySnapshot>(
                  stream: dataStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      // TODO : add snackbar
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final List storedocs = [];
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      storedocs.add(a);
                      a['UID'] = document.id;
                    }).toList();
                    return Column(
                        children: List.generate(
                            storedocs.length,
                            (i) => SingleChildScrollView(
                                  child: Form(
                                    key: _reportFormKey,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center, //ارجعي له في حال خرب علينا
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
                                                hintText:
                                                    'Enter the title of problem',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                )),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),

                                        //بعد السايز بوكس نحط الفور يفلد بحط الباقي نوت
                                        Text("Enter the problem description *"),
                                        // : Text('Sent Message: ${_Textcontroller.value.text}'),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextFormField(
                                              // controller: _Textcontroller,
                                              minLines: 2,
                                              maxLines: 5,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .deny(
                                                  RegExp(r"\s\s"),
                                                )
                                              ],
                                              textInputAction:
                                                  TextInputAction.done,
                                              //keyboardType: TextInputType.text,
                                              onChanged: (value) {
                                                setState(() {
                                                  problem = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'Enter your problem here',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  isDense:
                                                      true, //اضفت هذي عشان الفالديتير
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  )),
                                              //   autovalidateMode: AutovalidateMode.onUserInteraction,
                                              validator: (textValue) {
                                                if (textValue == null ||
                                                    textValue.isEmpty) {
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
                                            if (_reportFormKey.currentState!
                                                .validate()) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          WelcomeScreen()));
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
                                                  title: const Text(
                                                      "Report problem Successfully"),
                                                  content: const Text(
                                                      "your report was successfully submitted"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: Container(
                                                        // color: Colors.green,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(14),
                                                        child:
                                                            const Text("okay"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                              await FirebaseFirestore.instance
                                                  .collection("Problem-Report")
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .set({
                                                'tilte': tilte,
                                                'problem': problem,
                                                'UID': FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                'CUID': widget.campaignId,
                                                'Cname': widget.campaignName
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )));
                  }))
        ])));
  }
}
*/