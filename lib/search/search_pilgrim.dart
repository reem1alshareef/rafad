import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:rafad1/search/pilgrim_design_widget.dart';
import 'package:rafad1/search/user.dart';

class SearchPilgrim extends StatefulWidget {
  const SearchPilgrim({super.key});

  @override
  State<SearchPilgrim> createState() => _SearchPilgrimState();
}

class _SearchPilgrimState extends State<SearchPilgrim> {


Future<QuerySnapshot>? postDocumentsList;
String userNameText = '';
initSearchingPilgrim(String textEntered){
  /*FirebaseFirestore.instance
    .collection('AcceptedCampaigns')
    .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .collection('pilgrimsRequest')
    .where('name', isEqualTo: textEntered)
    .get();*/
    postDocumentsList = FirebaseFirestore.instance
        .collection('AcceptedCampaigns')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('AcceptedPilgrims')
        .where('name', isEqualTo: textEntered)
        .get();

        setState(() {
          postDocumentsList;
        });

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            onChanged: (textEntered){
              setState(() {
                userNameText = textEntered;
              });
              initSearchingPilgrim(textEntered);
            },
            decoration: InputDecoration(
              hintText: "Search for pilgrim",
              hintStyle: const TextStyle(color: Colors.white),
              suffixIcon: IconButton(icon: const Icon(Icons.search, color: Colors.white,),
              onPressed: (){
                initSearchingPilgrim(userNameText);

              },
              )
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor:  Color.fromARGB(255, 12, 92, 119),
          elevation: 0,
          actions: const [
            SizedBox(height: 30),
          ],
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: postDocumentsList,
          builder: (context, AsyncSnapshot snapshot){
            return snapshot.hasData
            ?
            ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Users model = Users.fromJson(
                  snapshot.data!.docs[index].data()! as Map<String, dynamic>
                );
                return UsersDesignWidget(
                  model: model,
                  context: context,
                  );
              }
              )
              :
              const Center(child: Text("No pilgrim exists"),);
              }
              )
    );
          }
    
}