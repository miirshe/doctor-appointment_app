import 'package:flutter/foundation.dart';

class PatientLoginModel {
   String? id;
   String? name;
   String? email;
   int? phone;
   String? address;
   String? image;

  PatientLoginModel({this.id, this.name, this.email, this.phone, this.address, this.image});
  factory PatientLoginModel.fromJson(Map<String, dynamic> json) {
    return PatientLoginModel(
        id : json['id'],
        name : json['name'],
        email : json['email'],
        phone : json['phone'],
        address : json['address'],
        image : json['image']);
  }
  Map<String , dynamic> toJson(){
    final Map<String , dynamic> data = <String , dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['image'] = image;
    return data;
  }
}
