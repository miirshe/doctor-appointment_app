import 'dart:convert';

import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/providers/BASE_URL.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AppointmentDetailProvider extends ChangeNotifier{
  Future<List<AppointmentDetailModel>> getAppointmentDetail() async {
    List<AppointmentDetailModel> appointmentModel = [];
    try{
      http.Response response = await http.get(Uri.parse(KEndPoint + 'GetAppointmentDetails'));
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        final data = jsonData['data'];
        appointmentModel = (data as List<dynamic>).map((e) => AppointmentDetailModel.fromJson(e)).toList();
      }

    }catch(error){
      print('error ${error}');
    }
    return appointmentModel;
  }
}