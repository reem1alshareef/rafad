import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:rafad1/search/campaign_design_widget.dart';
import 'package:rafad1/search/user1.dart';

import '../screens/Chat_screen.dart';

class SearchCampaign extends StatefulWidget {
  const SearchCampaign({super.key});

  @override
  State<SearchCampaign> createState() => _SearchCampaignState();
}

class _SearchCampaignState extends State<SearchCampaign> {


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
        //.doc(FirebaseAuth.instance.currentUser!.uid)
        //.collection('pilgrimsRequest')
        .where('name', isEqualTo: textEntered)
        .get();

        setState(() {
          postDocumentsList;
        });

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF455D83),
          tooltip: 'Chat',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Chat_screen()),
            );
          },
          child: Image.asset('assests/images/chat.png', height: 35),
        ),

        appBar: AppBar(
          title: TextField(
            onChanged: (textEntered){
              setState(() {
                userNameText = textEntered;
              });
              initSearchingPilgrim(textEntered);
            },
            decoration: InputDecoration(
              hintText: "Search for campaign",
              hintStyle: const TextStyle(color: Colors.white),
              suffixIcon: IconButton(icon: const Icon(Icons.search, color: Colors.white,),
              onPressed: (){
                initSearchingPilgrim(userNameText);

              },
              )
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor:   Color(0xFF455D83),
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
              const Center(child: Text("No campaign exists"),);
              }
              )
    );
          }
    
}