import 'dart:convert';
import 'dart:io';
import 'package:doctor_appointments/providers/BASE_URL.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterProvider extends ChangeNotifier {
  late String message;

  registerPatient(String name, String email, String phone,
      String address, String password, String image,BuildContext context) async {
    try {
      http.Response response = await http.post(
        Uri.parse(KEndPoint + 'registerPatient'),
        body: {
          'name': name,
          'email': email,
          'phone': phone.toString(),
          'address': address,
          'image': image,
          'password': password
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        message = jsonData['data'];
        showAlert(context);
        Navigator.of(context).pushNamed('/login');
      }
    } on SocketException {
      print('Failed Network Access');
    } catch (error) {
      print("failed to retrieve response $error");
    }
  }

  showAlert(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)),);
  }
}
