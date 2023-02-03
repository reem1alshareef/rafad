import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafad1/screens/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import '../widgets/my_button.dart';


class Delete_my_account extends StatefulWidget {
  const Delete_my_account({super.key});

  @override
  State<Delete_my_account> createState() => _Delete_my_accountState();
}

class _Delete_my_accountState extends State<Delete_my_account> {
  /*int index = 0;
  final screens =[
    Center(child: Text('mail', style: TextStyle(fontSize: 72),),),
    Center(child: Text('mail', style: TextStyle(fontSize: 72),),),
    Center(child: Text('mail', style: TextStyle(fontSize: 72),),),
    AddDescription(),
    Center(child: Text('mail', style: TextStyle(fontSize: 72),),),

  ];*/
  final TextEditingController _descController = TextEditingController();
  final _addDescKey = GlobalKey<FormState>();
  final _review = GlobalKey<FormState>();
  String? description;

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  Future deleteAccount() async{
    if (_addDescKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
      content: Text('Submitting data..')),
    );
  }

  
  }

  @override
  Widget build(BuildContext context) {  
        return Scaffold(
          body: SingleChildScrollView(
           child: Column (
             children: [
           //SizedBox(height: 40,),
          ButtonBar(
                  alignment:
                      MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0)),)),
                      onPressed: () {
                        showDialog(
                             context: context,
                            builder:
                                (BuildContext context) {
                              return AlertDialog(
                          title: Row(
                            children:  const [
                              Text('Delete '),
                              Text(' account'),
                            ],
                          ),
                          content: Row(
                            children:  const [
                              Text('Deleting this account '),
                              Text('cannot ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                              Text('be undone, Are you sure you want to delete the account?')
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child:  const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                
                                //firebase
                                try{
                                  setState(
                                            () async {
                                              DocumentSnapshot docCustomer = await FirebaseFirestore.instance
                              .collection('Pilgrims-Account')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .get();

                             String email = docCustomer['email'];
                             String password = docCustomer['password'];
                             
                          // final docCustomer = FirebaseFirestore.instance
                          //     .collection('customers')
                          //     .doc(uid);
                          /*AsyncSnapshot snapshot = ;
                          final customer = snapshot.data;

                          String email = customer.email;
                          String password = customer.password;

                          // Create a credential
                          AuthCredential credential =
                              EmailAuthProvider.credential(
                                  email: email, password: password);

                          // Reauthenticate
                          await FirebaseAuth.instance.currentUser!
                              .reauthenticateWithCredential(credential);*/

                          FirebaseAuth.instance.currentUser?.delete();

                                              User? user = await FirebaseAuth.instance.currentUser;
                                              UserCredential authResult= await user!.reauthenticateWithCredential(
                                                EmailAuthProvider.credential(
                                                email: email,
                                                password: password,
                                              ),);

                                              authResult.user!.delete();

                                            // ignore: use_build_context_synchronously
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const WelcomeScreen()));


                                        });
                                  //Navigator.pop(context, 'Delete');
                                  
                                } catch(e){
                                  //e.hashCode;
                                  //print(e.runtimeType);

                                }

                               

                              },//=> Navigator.pop(context, 'OK'),
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                        }
                        );
                        
                      },



                      child: Row(
                        children: const <Widget>[
                          Icon(Icons.cancel_rounded, color: Colors.redAccent),
                          Padding(padding: EdgeInsets.symmetric(vertical: 2.0),),
                          Text(' Delete account'),
                        ],
                      ),



                    ),
                  ],
                ),


              ]
            )
          )
                );
  }
  }