import 'dart:convert';
import 'dart:io';

import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/providers/BASE_URL.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SpecialitiesProvider extends ChangeNotifier{
  Future<List<SpecialitiesModel>> getSpecialities() async {
    List<SpecialitiesModel> specialitiesModel = [];
    try {
      http.Response response = await http.get(Uri.parse(KEndPoint + 'getSpecialities'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List data = jsonData['data'];
        specialitiesModel =
            data.map((e) => SpecialitiesModel.fromJson(e)).toList();
      } else {
        print('no found data');
      }
    } on SocketException {
      print('No internet access');
    } catch (error) {
      print(error);

    }

    return specialitiesModel;
  }

}