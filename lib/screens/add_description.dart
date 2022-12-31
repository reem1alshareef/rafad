import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import '../widgets/my_button.dart';


class AddDescription extends StatefulWidget {
  const AddDescription({super.key});

  @override
  State<AddDescription> createState() => _AddDescriptionState();
}

class _AddDescriptionState extends State<AddDescription> {
  final TextEditingController _descController = TextEditingController();
  final _addDescKey = GlobalKey<FormState>();
  

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  Future addDescription() async{
    if (_addDescKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
      content: Text('Submitting data..')),
    );
      await FirebaseFirestore.instance
            .collection("campaign_description")
            .add({
              'description': _descController,
              'posted_by': FirebaseAuth.instance.currentUser!.uid,
            });
  }
  }

  @override
  Widget build(BuildContext context) {  
        return Scaffold(
        appBar: AppBar(
          title: const Text("Add Description"),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
          actions: const [
            SizedBox(height: 30),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assests/images/background.png"),
                  fit: BoxFit.cover)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [ 
                    TextFormField(
                          controller: _descController,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(labelText: 'Description'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Description is required!';
                            }
                            return null;
                          }
               ),
                    const SizedBox(
                          height: 20,
                        ),
                    MyButton(
                          color: const Color(0xFF455D83),
                          title: 'Add Description',
                          onPressed: addDescription,
                        ),
                  ]
              ),
             ],
          ),
        ),
        );
  }
  }
  
