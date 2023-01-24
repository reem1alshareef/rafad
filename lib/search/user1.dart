import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';


class Users{
  String? email;
  String? name;
  String? address;
  String? commercial_ID;
  String? phoneNumber;
  String? seatingCapacity;
  String? description;
  String? UID;

Users({
  this.email,
  this.name,
  this.address,
  this.commercial_ID,
  this.phoneNumber,
  this.seatingCapacity,
  this.description,
  this.UID,
});

Users.fromJson(Map <String, dynamic> json){
email = json['email'];
name = json['name'];
address = json['address'];
commercial_ID = json['commercial_ID'];
phoneNumber = json['phoneNumber'];
seatingCapacity = json['seatingCapacity'];
description = json['description'];
UID = json['UID'];
}

Map<String, dynamic> toJson(){
  
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['email'] = email;
  data['name'] = name;
  data['address'] = address;
  data['commercial_ID'] = commercial_ID;
  data['phoneNumber'] = phoneNumber;
  data['seatingCapacity'] = seatingCapacity;
  data['description'] = description;
  data['UID'] = UID;

return data;
}
}