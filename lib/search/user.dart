import 'package:cloud_firestore/cloud_firestore.dart';


class Users{
  String? email;
  String? name;
  String? id;

Users({
  this.email,
  this.name,
  this.id,
});

Users.fromJson(Map <String, dynamic> json){
email = json['email'];
name = json['name'];
id = json['id'];
}

Map<String, dynamic> toJson(){
  
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['email'] = email;
  data['name'] = name;
  data['id'] = id;

return data;
}
}