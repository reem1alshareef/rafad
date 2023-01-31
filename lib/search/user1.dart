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
  String? numberOfRatings;
  String? numberOfPeople;
  String? avrgRating;

Users({
  this.email,
  this.name,
  this.address,
  this.commercial_ID,
  this.phoneNumber,
  this.seatingCapacity,
  this.description,
  this.UID,
  this.numberOfRatings,
  this.numberOfPeople,
  this.avrgRating
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
numberOfRatings = json['numberOfRatings'];
numberOfPeople = json['numberOfPeople'];
avrgRating = json['avrgRating'];
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
  data['numberOfRatings'] = numberOfRatings;
  data['numberOfPeople'] = numberOfPeople;
  data['avrgRating'] = avrgRating;

return data;
}
}