import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointments/constants.dart';
import 'package:doctor_appointments/providers/constants.dart';
import 'package:doctor_appointments/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key});
  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginPatientProvider>(
      builder: (context, login, _) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Constants.primaryBgColor,
          title: Text(
            'Profile',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 2),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: Constants.primaryBgColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child:
                Column(
                  children: [
                    Gap(10),
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            CachedNetworkImageProvider(login.user!.image ?? ''),
                      ),
                    ),
                    Gap(10),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        login.user!.name ?? '',
                        style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            letterSpacing: 2),
                      ),
                    )
                  ],
                ),
              ),
              Gap(2),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Constants.primaryBgColor,
                    size: 25,
                  ),
                  title: Text(
                    login.user!.email ?? '',
                    style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: Colors.grey.shade700,
                        letterSpacing: 1.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: Constants.primaryBgColor,
                    size: 25,
                  ),
                  title: Text(
                    login.user!.address ?? '',
                    style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Colors.grey.shade900,
                        letterSpacing: 1.5),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Constants.primaryBgColor,
                    size: 25,
                  ),
                  title: Text(
                    login.user!.phone.toString() ?? '',
                    style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Colors.grey.shade900,
                        letterSpacing: 1.5),
                  ),
                ),
              ),

              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Text(
                    'Other aditional option',
                    style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Colors.grey.shade900,
                        letterSpacing: 1.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  child: 
                  InkWell(
                    child: ListTile(
                      leading: Icon(
                        Icons.edit,
                        color: Constants.primaryBgColor,
                        size: 25,
                      ),
                      title: Text(
                        'Edit Profile',
                        style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            color: Colors.grey.shade900,
                            letterSpacing: 1.5),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Constants.primaryBgColor,
                  child: InkWell(
                    onTap: (){
                      login.logoutUser(context);
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 25,
                      ),
                      title: Text(
                        'Logout',
                        style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            letterSpacing: 1.5),
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
