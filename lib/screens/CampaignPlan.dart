import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafad1/screens/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import '../widgets/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:rafad1/services/localNotifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rafad1/screens/notification_accept.dart';
class CampaignPlan extends StatefulWidget {
  
  const CampaignPlan({super.key});

  @override
  State<CampaignPlan> createState() => _CampaignPlan();
}

class _CampaignPlan extends State<CampaignPlan> {
  
  final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('AcceptedCampaigns')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Activities').snapshots();
  late final List storedocs = [];

  final TextEditingController _descController = TextEditingController();
  final _addTitleKey = GlobalKey<FormState>();
  String? description;
 //TimeOfDay time=TimeOfDay(hour: 00, minute: 00);
  TimeOfDay time=TimeOfDay.now();
  DateTime date=DateTime.now();
  late DateTime datetime;
  String title="no information available";

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  Future addActivity() async{
    print('reached add activity');
    if (_addTitleKey.currentState!.validate()) {

      print('reached condition');
      date=DateTime(date.year,date.month,date.day,time.hour,time.minute);
      DocumentReference docRef = await FirebaseFirestore.instance
            .collection("AcceptedCampaigns")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('Activities')
            .add({
                                    'title': title,
                                    'time':Timestamp.fromDate(date),
                                    //'activityID':document.documentID,
                                  },);
      await docRef.set({
        'activityID':docRef.id,
      }, SetOptions(merge: true));
                                  
                                
  }

  
  }

  @override
  Widget build(BuildContext context) {  
    
        //int theHour;
        
        return Scaffold(
          
        

        body:Container(
          child: SingleChildScrollView(
          child: Column(
            children: [
             const SizedBox(height: 37),
             
Row(children: [
              const SizedBox(width: 10),
              Ink(
              
              decoration: const ShapeDecoration(
                color: const Color(0xFF455D83),
                shape: CircleBorder(),
                
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications),
                  tooltip: 'Show Snackbar',
                  color:const Color.fromARGB(255, 255, 255, 255),
                  onPressed: () {

                    //LocalNotifications().showNotification(title: 'hello from the other side', body: 'hi');
                    //NotificationService().showNotification(
                      //1, 'Notification_title.text,' ,'Notification_descrp.text');



                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This button is for future improvment')));
                      
                  },
                ),
            ),
             ],
             ),
             const SizedBox(width: 10, height: 30,),
             Container(
              decoration: BoxDecoration(
    color: Colors.blueGrey[50],
    border: Border.all(
      color: Color.fromARGB(255, 249, 250, 251),
      width: 8,
    ),
    borderRadius: BorderRadius.circular(30),//was 12 ---------------------------------------------------------------------------------------------------------
  ),
              child:Column(children: [
             

            SizedBox(height: 10),


            //add activity start
            Row(
              children: [



              //add date
              Container(
                margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(0.1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromARGB(255, 125, 148, 184)),
                child: IconButton(//start date icon
                  onPressed: (){//start get date from user
                    showDatePicker(context: context,
                     initialDate: DateTime.now(),//default date
                      firstDate: DateTime.now(),//limit the date, the start
                       lastDate: DateTime(2023,1,29))//limit the date the end
                       .then((value) {
                        setState(() {
                          date=value!;//set date to a variable
                        });
                       });
                  },//end get date from user
                  icon: Icon(Icons.edit_calendar_outlined),// end date icon
                  color:Color.fromARGB(255, 251, 251, 252),
                ),
              ),
                Text('${date.day}/${date.month}'),//print date
                






              //add time
              Container(
                margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(0.1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromARGB(255, 125, 148, 184)),
                child: IconButton(//start time icon
                  icon: const Icon(Icons.timer),
                  tooltip: 'Time Picker',
                  color:Color.fromARGB(255, 251, 251, 252),
                  onPressed: ()  async {
                    showTimePicker(//start get data from user
                      context: context, 
                      initialTime: TimeOfDay.now(),
                      builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  alwaysUse24HourFormat: true),//make time 24 hours
              child: childWidget!);
              })//end get data from user
                      .then((value){
                        setState(() {
                          time=value!;//set time to variable
                        });
                      });
                      },
                      ),//end time icon


                ),  
                      

Text('${time.hour}:${time.minute}'),//print time
                 


const SizedBox(width: 10),


              //add title
              Flexible(child:Form(key: _addTitleKey,
                child:  //jjjjjjj
              TextFormField(
                //key: _addTitleKey,
                maxLines: 1,
                          maxLength: 20,
                          
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
                              title = value;
                            });
                          },
                          decoration: const InputDecoration(labelText: 'Title'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Title is required!';
                            }
                            if(textValue.length<5){
                              return 'Title should be 5 characters at least';
                            }
                            
                            //return null;
                            if(textValue.trim().isEmpty){
                            return "Title cannot be empty.";
                            }

                            if(!textValue.contains(RegExp(r'[a-z]'))){
                              return("Title must contain letters");
                            }

                            return null;
                          }
                          ,)
              )
              
              
              ),

              IconButton(onPressed: (){
                print('reached submition');
                addActivity();
              }, icon: const Icon(Icons.arrow_forward))
             
              






              ]
),

SizedBox(height: 10,),
              ],)
             ),
             



//add activity end



//data output

       Padding(
              padding:
                 EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: StreamBuilder<QuerySnapshot>(
                  stream: dataStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      // TODO : add snackbar
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final List storedocs = [];
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      storedocs.add(a);
                      a['id'] = document.id;
                    }).toList();
                    return Column(
                        children: List.generate(
                          
                            storedocs.length,
                             (i) => Column(children: [
                               
                              Container(
                                 width: double.infinity,
                                decoration: BoxDecoration(
    color: Colors.blueGrey[50],
    border: Border.all(
      color: Color.fromARGB(255, 249, 250, 251),
      width: 8,
    ),
    borderRadius: BorderRadius.circular(30),
  ),


                               

                                child: Column(children: [

                                  SizedBox(height: 10,),
                                  

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    
                                    SizedBox(width: 15,),
                                    Center(
                                    child:Text(storedocs[i]['title']),
                                    ),
                                    SizedBox(width: 40,),

                                   const Icon(Icons.calendar_today),
                                   Text(
                                      ' ${storedocs[i]['time'].toDate().day} / ${storedocs[i]['time'].toDate().month} / ${storedocs[i]['time'].toDate().year} '),

                                   const Icon(Icons.timer),
                                   Text(
                                      ' ${storedocs[i]['time'].toDate().hour}:${storedocs[i]['time'].toDate().minute}'),




                                   IconButton(
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    onPressed: (){

                                    FirebaseFirestore.instance.collection("AcceptedCampaigns").doc(FirebaseAuth.instance.currentUser!.uid)
                                         .collection("Activities").doc(storedocs[i]['activityID'])
                                         .delete();

                                   }, icon: Icon(Icons.cancel))
                                  ],),
                                  


                                  SizedBox(height: 10,),



        
                                  
                                ],)

                                
                              ),
                             ],)
                             
                             
                                )
                                );
                  }))



              ],
              ),


        ),


        )
        
        
        );
            
            






  }
}

  