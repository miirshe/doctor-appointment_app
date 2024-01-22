import 'dart:convert';
import 'dart:io';
import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/providers/BASE_URL.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DoctorProvider extends ChangeNotifier {
  Future<List<DoctorModel>> getDoctors() async {
    List<DoctorModel> doctorModel = [];
    try {
      http.Response response =
          await http.get(Uri.parse(KEndPoint + 'getDoctors'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List data = jsonData['data'];
        doctorModel =
            data.map((e) => DoctorModel.fromJson(e)).toList();

      } else {
        print('no found data');
      }
    } on SocketException {
      print('No internet access');
    } catch (error) {
      print(error);
    }
    return doctorModel;
  }
}
