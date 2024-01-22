import 'dart:convert';

import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/providers/BASE_URL.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DiagnosesProvider extends ChangeNotifier {
  String? message;
  Future<List<DiagnosesModel>> getDiagnoses(BuildContext context) async {
    List<DiagnosesModel> diagnosesModel = [];

    try {
      http.Response response = await http.get(
        Uri.parse(KEndPoint + 'getDiagnoses'),
      );
      if (response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        final bool status = jsonData['status'];
        final data = jsonData['data'];
        print(data);
        if(status == true){
          diagnosesModel = (data as List<dynamic>).map((e) => DiagnosesModel.fromJson(e)).toList();
        }else{
          message = data;
          showAlert(context);
        }
      }
    } catch (error) {
      print("Failed to retrieve diagnoses data $error");
    }

    return diagnosesModel;
  }

  showAlert(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message!,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.white,
            letterSpacing: 1.5,
            height: 1.9,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.red.shade500,
        duration: Duration(seconds: 5),
        elevation: 8,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
