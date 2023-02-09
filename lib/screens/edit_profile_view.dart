/*import 'package:flutter/material.dart';
import 'package:rafad1/core.dart';
import 'package:rafad1/data/app_session.dart';
import 'package:rafad1/screens/edit_profile_controller.dart';

import 'package:get/get.dart';

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: Text("EditProfile"),
            actions: [
              InkWell(
                onTap: () => controller.doEdit(),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Save"),
                ),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                
                ExTextField(
                  id: "name",
                  label: "Name",
                ),
                ExTextField(
                  id: "email",
                  label: "Email",
                  value: currentUser.email,
                  enabled: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}*/