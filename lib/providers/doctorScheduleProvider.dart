import 'dart:convert';
import 'dart:io';
import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/providers/BASE_URL.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DoctorScheduleProvider extends ChangeNotifier {
  Future<List<DoctorScheduleModel>> getDoctorSchedule() async {
    List<DoctorScheduleModel> doctorScheduleModel = [];
    try {
      http.Response response =
          await http.get(Uri.parse(KEndPoint + 'getDoctorSchedules'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List data = jsonData['data'];
        doctorScheduleModel = data.map((e) => DoctorScheduleModel.fromJson(e)).toList();
        print(data);
      } else {
        print(response.body);
      }
    } on SocketException {
      print('Failed Network Access');
    } catch (error) {
      print(error);
    }

    return doctorScheduleModel;
  }
}
