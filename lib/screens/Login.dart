import 'package:doctor_appointments/constants.dart';
import 'package:doctor_appointments/providers/providers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

extension StringEx on String {
  bool get isEmail => this.contains("@");
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool ishidden = true;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginPatientProvider>(
      builder: (context, loading, _) => ModalProgressHUD(
        inAsyncCall: loading.isloading,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Constants.primaryBgColor,
            title: Text(
              'Login',
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                letterSpacing: 2,
                height: 2,
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Welcome Back!',
                              style: GoogleFonts.poppins(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                                letterSpacing: 2,
                                height: 2,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '\nTo keep connected with us please login with your personal info',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                    letterSpacing: 1.5,
                                    height: 1.9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val != null) {
                                if (val.isEmpty) return 'email is required';
                                if (!val.isEmail) return 'invalid email';
                              }
                            },
                            onSaved: (newVal) => email = newVal!,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Colors.black,
                              letterSpacing: 1.5,
                              height: 1.9,
                            ),
                            decoration: InputDecoration(
                              errorStyle: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: Colors.red,
                                letterSpacing: 1.5,
                                height: 1.9,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'Email Address',
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            onSaved: (newVal) => password = newVal!,
                            validator: (val) {
                              if (val != null) {
                                if (val.isEmpty) {
                                  return 'password is required';
                                }
                              }
                            },
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Colors.black,
                              letterSpacing: 1.5,
                              height: 1.9,
                            ),
                            obscureText: ishidden,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              errorStyle: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: Colors.red,
                                letterSpacing: 1.5,
                                height: 1.9,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(ishidden
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    ishidden = !ishidden;
                                  });
                                },
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Password',
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/forget_password');
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                  width: double.infinity,
                                  child: Text(
                                    'Forget Password',
                                    style: Constants.smallTextStyle,
                                    textAlign: TextAlign.end,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                            child: InkWell(
                              onTap: () {
                                _formkey.currentState!.save();
                                if (_formkey.currentState!.validate()) {
                                  Provider.of<LoginPatientProvider>(context,
                                          listen: false)
                                      .loginPatientProvider(
                                          email, password, context);
                                }
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).primaryColor),
                                  width: double.infinity,
                                  height: 60,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              width: double.infinity,
                              child: RichText(
                                text: TextSpan(
                                    text: 'Don\'t have an account?',
                                    style: Constants.smallTextStyle,
                                    children: [
                                      TextSpan(
                                          text: '\nCreate an account',
                                          style: TextStyle(
                                              fontSize: 18,
                                              letterSpacing: 1.5,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushNamed(
                                                  context, '/register');
                                            }),
                                    ]),
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
