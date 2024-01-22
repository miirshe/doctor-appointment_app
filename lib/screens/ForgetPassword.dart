import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: Colors.blue,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: double.infinity,
              height: 120,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Forget Password ?',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5,
                      color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          width: double.infinity,
                          child: Text(
                            'Don\'t worries we\'ll send you reset instruction ',
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,height: 2, letterSpacing: 2),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(int.parse('0xffF6F8FA'))),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Your Email',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue),
                            width: double.infinity,
                            height: 60,
                            child: Text(
                              'Send',
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 2,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
