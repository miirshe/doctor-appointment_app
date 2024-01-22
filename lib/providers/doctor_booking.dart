import 'dart:convert';

import 'package:doctor_appointments/providers/BASE_URL.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DoctorBookingProvider extends ChangeNotifier {
  late bool status;
  late String message;

  Future<void> createDoctorBooking(
      String date,
      String day,
      String time,
      String doc_id,
      String pat_id,
      String description,
      BuildContext context) async {
    try {
      http.Response response =
          await http.post(Uri.parse(KEndPoint + 'createAppointment'), body: {
        'date': date,
        'day': day,
        'time': time,
        'status': 'pending',
        'doc_id': doc_id,
        'pat_id': pat_id,
        'symptom_desc': description
      });
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        status = jsonData['status'];
        message = jsonData['data'];
        if (status == true) {
          showAlert(context,message,'1F8A70');
        }
      }
    } catch (error) {
      print('failed to create doctor booking ${error}');
    }
  }

  void showAlert(BuildContext context, String message, String color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
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
        backgroundColor:Color(int.parse('0xff$color')),
        duration: Duration(seconds: 5),
        elevation: 8,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
