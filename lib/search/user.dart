import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';


class Users{
  String? email;
  String? name;
  String? pilgrimID;
  String? pharma;
  String? disease;
  String? hajId;
  String? phone;

Users({
  this.email,
  this.name,
  this.pilgrimID,
  this.pharma,
  this.disease,
  this.hajId,
  this.phone,
});

Users.fromJson(Map <String, dynamic> json){
email = json['email'];
name = json['name'];
pilgrimID = json['pilgrimID'];
pharma = json['pharma'];
disease = json['disease'];
hajId = json['hajId'];
phone = json['phone'];
}

Map<String, dynamic> toJson(){
  
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['email'] = email;
  data['name'] = name;
  data['pilgrimID'] = pilgrimID;
  data['pharma'] = pharma;
  data['disease'] = disease;
  data['hajId'] = hajId;
  data['phone'] = phone;

return data;
}
}