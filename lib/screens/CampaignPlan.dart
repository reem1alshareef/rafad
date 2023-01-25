import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafad1/screens/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import '../widgets/my_button.dart';


class CampaignPlan extends StatefulWidget {
  const CampaignPlan({super.key});

  @override
  State<CampaignPlan> createState() => _CampaignPlan();
}

class _CampaignPlan extends State<CampaignPlan> {
  final TextEditingController _descController = TextEditingController();
  final _addDescKey = GlobalKey<FormState>();
  String? description;

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
            .collection("AcceptedCampaigns")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
              'description': description,

            });
  }

  
  }

  @override
  Widget build(BuildContext context) {  
        return Scaffold(
        appBar: AppBar(
          title: const Text("Plan"),
          backgroundColor: const Color(0xFF455D83),
          //elevation: 0,
          actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          ]
        ),
       
          // body: Container(
          // decoration: const BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage("assests/images/background.png"),
          //         fit: BoxFit.cover)),
          // child: Form(
          //   key: _addDescKey,
          //     child: 
          //       Column(
          //         children: [ 
          //              Container(
                      
          //          child: SingleChildScrollView(
          //           child: Column (
          //             children: [
          //               //SizedBox(height: 40,),
          //           TextFormField(
          //                 maxLines: 3,
          //                 maxLength: 200,
                          
          //                 inputFormatters: [
          //                   FilteringTextInputFormatter.deny
          //                   (RegExp(r"\s\s"),)
          //                 ],
                          
          //                 //controller: _descController,
          //                 cursorColor: Colors.white,
          //                 style: TextStyle(color: Colors.grey[500],) ,
          //                 textInputAction: TextInputAction.done,
          //                 keyboardType: TextInputType.text,
          //                 onChanged: (value) {
          //                   setState(() {
          //                     description = value;
          //                   });
          //                 },
          //                 decoration: const InputDecoration(labelText: 'Description'),
          //                 autovalidateMode: AutovalidateMode.onUserInteraction,
          //                 validator: (textValue) {
          //                   if (textValue == null || textValue.isEmpty) {
          //                     return 'Description is required!';
          //                   }
          //                   if(textValue.length<20){
          //                     return 'Describtion should be 20 characters at least';
          //                   }
                            
          //                   //return null;
          //                   if(textValue.trim().isEmpty){
          //                   return "Description cannot be empty.";
          //                   }

          //                   return null;
          //                 }
          //                  ),
          //           const SizedBox(
          //                 height: 20,
          //               ),
          //           MyButton(
          //                 color: const Color(0xFF455D83),
          //                 title: 'Add Description',
          //                 onPressed: addDescription,
          //               ),
          //         ]
          //         )
          //       ))]
          //       )
          //     ),
          //     )
            
          
        );
  }
  }