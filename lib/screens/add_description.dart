import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafad1/screens/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import '../widgets/my_button.dart';


class AddDescription extends StatefulWidget {
  const AddDescription({super.key});

  @override
  State<AddDescription> createState() => _AddDescriptionState();
}

class _AddDescriptionState extends State<AddDescription> {
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

            showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                  'Submitted successfully!'),
            );
          });
            /*Navigator.push(
              context, MaterialPageRoute(builder: (context) => ViewDescription()));*/
  }

  
  }

  @override
  Widget build(BuildContext context) {  
        return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
           actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, WelcomeScreen.screenRoute);
              },
            )
          ],
        ),
        /*body: screens[index],
        bottomNavigationBar: 
        NavigationBar(
          height: 60,
          backgroundColor: Color(0xFF455D83),
          selectedIndex: index,
          onDestinationSelected: (index) => 
          setState(() => this.index = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.request_page_outlined),
            label: 'Request',),
          NavigationDestination(
            icon: Icon(Icons.announcement_outlined),
            label: 'Anouncement',),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Pilgrims',),
          NavigationDestination(
            icon: Icon(Icons.description_outlined),
            label: 'Description',),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',),

        ],),*/
       
          body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assests/images/background.png"),
                  fit: BoxFit.cover)),
          child: Form(
            key: _addDescKey,
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              child: 
                Column(
                  children: [ 
                       Container(
                      
                   child: SingleChildScrollView(
                    child: Column (
                      children: [
                        //SizedBox(height: 40,),
                    TextFormField(
                          maxLines: 3,
                          maxLength: 200,
                          
                          inputFormatters: [
                            FilteringTextInputFormatter.deny
                            (RegExp(r"\s\s"),)
                          ],
                          
                          //controller: _descController,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.grey[500],) ,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                          decoration: const InputDecoration(labelText: 'Description'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Description is required!';
                            }
                            if(textValue.length<20){
                              return 'Describtion should be 20 characters at least';
                            }
                            
                            //return null;
                            if(textValue.trim().isEmpty){
                            return "Description cannot be empty.";
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
                  )
                ))]
                )
              ),
              )
            
          
        );
  }
  }
  
/*class ViewDescription extends StatefulWidget {
  const ViewDescription({super.key});

  @override
  State<ViewDescription> createState() => _ViewDescriptionState();
}

class _ViewDescriptionState extends State<ViewDescription> {
//final uid = FirebaseAuth.instance.currentUser!.uid;



final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance
        .collection('AcceptedCampaigns')
        .where("UID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Description"),
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
                    if(dataStream == null){

                      Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddDescription()));
                    }
                    final List storedocs = [];
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      storedocs.add(a);
                      a['UID'] = document.id;
                    }
                    
                    
                    
                    ).toList();
                    return Column(
                        children: List.generate(
                            storedocs.length,
                            (i) => SingleChildScrollView(
                                

          child: ExpansionTileCard(
                                    elevation: 2,
                                    initialPadding:
                                        EdgeInsets.only(bottom: 7, top: 7),
                                    baseColor: Colors.blueGrey[50],
                                    expandedColor: Colors.blueGrey[50],
                                    //key: cardA,
                                    leading: CircleAvatar(
                                      child: Image.asset(
                                          "assests/images/kaaba.png"),
                                      backgroundColor: Color(0xFF788AA4),
                                    ),
                                    subtitle: Text(
                                      "Click to view campaign's description",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    title: Text(""),
                                    children: [
                                      Divider(
                                        thickness: 1.7,
                                        height: 1.0,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 10.0,
                                          ),
                                          child: Center(
                                            child: Column(children: [
                                              Column(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Campaign\'s description:  ',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF455D83),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        storedocs[i]['description'],
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                  
                                                    ],
                                                  ),
                                                ),
        ],),],),),),),
          ],),
          
          ),
        )
        );
  }
  )
  )
  
  );
  }
  
  
  
  
  }*/
 