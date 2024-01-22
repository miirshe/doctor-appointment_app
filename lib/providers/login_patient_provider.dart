import 'dart:convert';

import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/providers/BASE_URL.dart';
import 'package:doctor_appointments/providers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginPatientProvider extends ChangeNotifier {
  late String message;
  PatientLoginModel? user;
  String? sessionToken;
  final box = GetStorage();
  bool isloading = false;

  LoginPatientProvider() {
    getUser();
    print('users $user');
    notifyListeners();
  }

  loginPatientProvider(
      String email, String password, BuildContext context) async {
    isloading = true;
    notifyListeners();
    try {
      http.Response response = await http.post(
        Uri.parse(KEndPoint + 'loginPatient'),
        body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        sessionToken = jsonData['session_token'];
        var data = jsonData['user'];
        user = PatientLoginModel.fromJson(data);
        print('user ${user!.name}');
        message = jsonData['data'];
        await saveUser(user!);
        showAlert(context);
        Navigator.of(context).pushNamed('/home'); // Use Navigator.of(context)
      } else {
        print('${response.body}');
      }
    } catch (error) {
      print("failed to login $error {'email': $email, 'password': $password}");
    }
    isloading = false;
    notifyListeners();
  }

  saveUser(PatientLoginModel user) {
    box.remove(USERINFO);
    box.write(USERINFO, user.toJson());
    box.write(ISLOGGEDIN, sessionToken);
  }

  getUser() {
    bool hasData = box.hasData(USERINFO);
    if (hasData == true) {
      var data = box.read(USERINFO);
      user = PatientLoginModel.fromJson(data);
      notifyListeners();
    } else {
      return null;
    }
  }

  logoutUser(BuildContext context) {
    bool hasData = box.hasData(USERINFO);
    if (hasData == true) {
      box.remove(USERINFO);
      box.remove(ISLOGGEDIN);
      notifyListeners();
      Navigator.of(context).pushNamed('/');
      // SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');

    }
  }

  showAlert(BuildContext context) {
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
        backgroundColor: Colors.green.shade500,
        duration: Duration(seconds: 5),
        elevation: 8,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
