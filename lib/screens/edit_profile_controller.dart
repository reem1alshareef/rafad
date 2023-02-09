/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafad1/core.dart';
import 'package:rafad1/data/app_session.dart';
import 'package:get/get.dart';
import 'package:rafad1/screens/edit_profile_view.dart';

class EditProfileController extends GetxController {
  EditProfileView? view;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  doEdit() async {
    var name = Input.get("name");

    await userCollection.update({
      "name": name,
     
    });

    Get.back();
  }
}*/