/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/data/app_session.dart';
import 'package:rafad1/screens/edit_profile_view.dart';

import 'package:rafad1/screens/profile_controller.dart';

import 'package:get/get.dart';
import 'package:rafad1/screens/profile_view.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        // ignore: unnecessary_cast
        controller.view = this ;

        return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
            actions: [
              InkWell(
                onTap: () => Get.to(EditProfileView()),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Edit"),
                ),
              ),
             
            ],
          ),
          body: StreamBuilder<DocumentSnapshot<Object?>>(
            stream: userCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text("Error");
              if (!snapshot.hasData) return Text("No Data");
              Map item = (snapshot.data!.data() as Map);

              return Container(
                padding: const EdgeInsets.all(20.0),
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: Get.width / 6,
                      backgroundColor: Colors.grey[300],
                     
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "${item["email"]}",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}*/