import 'package:doctor_appointments/constants.dart';
import 'package:doctor_appointments/providers/constants.dart';
import 'package:doctor_appointments/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  var hasData = GetStorage().hasData(ISLOGGEDIN);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xffF2F4F6)));
    return Consumer<LoginPatientProvider>(
      builder: (context, user, _) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/onlinedoc.png'),
                        fit: BoxFit.contain)),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RichText(
                    text: TextSpan(
                        text: 'Keep Your Family More Healthy',
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          letterSpacing: 2,
                          height: 2,
                        ),
                        children: [
                          TextSpan(
                            text:
                                "\n\nHealthcare , Health-care , or health care is the maintena improvement health via prevention , diagnoses of lines, injury or othet physical mental",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              letterSpacing: 1.5,
                              height: 1.9,
                            ),
                          )
                        ]),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(

          onPressed: () {},
          child: IconButton(
            onPressed: () {
              hasData
                  ? Navigator.pushNamed(context, '/home')
                  : Navigator.pushNamed(context, '/login');
            },
            icon: Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }
}
