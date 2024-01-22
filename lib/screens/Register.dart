import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:doctor_appointments/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointments/constants.dart';
import 'package:doctor_appointments/screens/Login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool ishidden = true;
  late String name;
  late String email;
  late String address;
  late String phone;
  late String password;

  File? _imageFile;
  String? _uploadedImageUrl;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<String?> _uploadImageToCloudinary(File imageFile) async {
    final cloudName = 'drkp17pqk';
    final uploadPreset = 'xkhmlycc';
    final apiKey = '359289291748428';

    final Uri apiUrl =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/upload');

    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    var request = http.MultipartRequest('POST', apiUrl)
      ..fields['upload_preset'] = uploadPreset
      ..fields['api_key'] = apiKey
      ..files.add(
          http.MultipartFile.fromBytes('file', imageBytes, filename: 'image'));

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseString);

    String? imageUrl = jsonResponse['secure_url'];

    return imageUrl;
  }

  Future<void> _uploadImage() async {
    if (_imageFile != null) {
      String? uploadedImageUrl = await _uploadImageToCloudinary(_imageFile!);
      if (uploadedImageUrl != null) {
        setState(() {
          _uploadedImageUrl = uploadedImageUrl;
        });
        print('Uploaded image URL: $_uploadedImageUrl');
      } else {
        print('Image upload failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Constants.primaryBgColor,
          title: Text(
            'Register',
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              color: Colors.white,
              letterSpacing: 2,
              height: 2,
            ),
          )),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: _uploadedImageUrl != null
                                    ? '$_uploadedImageUrl'
                                    : 'https://www.shareicon.net/data/128x128/2016/05/24/770117_people_512x512.png',
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _selectImage();
                            },
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: Constants.primaryBgColor,
                            ),
                          )
                        ],
                      ),
                      // Center(
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       _uploadImage();
                      //     },
                      //     child: Text('Upload Image to cloudinary '),
                      //   ),
                      // ),
                      Gap(10),
                      TextFormField(
                        onSaved: (newName) => name = newName!,
                        validator: (val) {
                          if (val != null) {
                            if (val.isEmpty) {
                              return 'Full Name is required';
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
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Name',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onSaved: (newEmail) => email = newEmail!,
                        validator: (val) {
                          if (val != null) {
                            if (val.isEmpty) {
                              return 'email is required';
                            }
                            if (!val.isEmail) {
                              return 'invalid email';
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
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Email Address',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onSaved: (newPhone) => phone = newPhone!,
                        validator: (val) {
                          if (val != null) {
                            if (val.isEmpty) {
                              return 'Phone number is required';
                            } else if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                              return 'Phone number must be numeric';
                            }
                          }
                          return null;
                        },
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
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Phone',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onSaved: (newAddress) => address = newAddress!,
                        validator: (val) {
                          if (val != null) {
                            if (val.isEmpty) {
                              return 'address contact is required';
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
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Address',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onSaved: (newPassword) => password = newPassword!,
                        validator: (val) {
                          if (val != null) {
                            if (val.isEmpty) {
                              return 'password is required';
                            }
                          }
                        },
                        obscureText: ishidden,
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
                        height: 20,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.primaryFontColor,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            await _uploadImage();
                            _formkey.currentState!.save();
                            if (_formkey.currentState!.validate()) {
                              Provider.of<RegisterProvider>(context,
                                      listen: false)
                                  .registerPatient(name, email, phone, address,
                                      password, _uploadedImageUrl!, context);
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Constants.primaryBgColor),
                              width: double.infinity,
                              height: 60,
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 18,
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
                                text: 'already have an account?',
                                style: Constants.smallTextStyle,
                                children: [
                                  TextSpan(
                                      text: ' Sign in',
                                      style: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 1.5,
                                          color: Constants.primaryBgColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, '/login');
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
    );
  }
}
