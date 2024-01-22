import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointments/constants.dart';
import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DoctorsSpecialities extends StatefulWidget {
  final String speciality;

  const DoctorsSpecialities({super.key, required this.speciality});

  @override
  State<DoctorsSpecialities> createState() => _DoctorsSpecialitiesState();
}

class _DoctorsSpecialitiesState extends State<DoctorsSpecialities> {
  @override
  Widget build(BuildContext context) {
    print("hi doctor specialities ${widget.speciality}");
    return Consumer<DoctorProvider>(
      builder: (context, doctors, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.primaryBgColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            '${widget.speciality}',
            style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                letterSpacing: 2),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: FutureBuilder<List<DoctorModel>>(
              future: doctors.getDoctors(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  default:
                    if (snapshot.data != null) {
                      List<DoctorModel> data = snapshot.data!;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, Index) {
                            if(data[Index].speciality == '${widget.speciality}'){
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(2, 6),
                                          blurRadius: 0.5,
                                          spreadRadius: 0.5,
                                          color:
                                          Constants.primaryBgColor)
                                    ]),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: Constants.primaryBgColor,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: data[Index].image,
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 150,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gap(17),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'DR.${"${data[Index].fname} ${data[Index].lname}"}',
                                          style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 2,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Gap(7),
                                        Text(
                                          data[Index].speciality,
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 2),
                                        ),
                                        Gap(7),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.verified,
                                              color: data[Index].status ==
                                                  'verified'
                                                  ? Colors.blue
                                                  : Colors.red,
                                              size: 20,
                                            ),
                                            Gap(5),
                                            Text(
                                              data[Index].status,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  letterSpacing: 2),
                                            ),
                                          ],
                                        ),
                                        Gap(7),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            Gap(5),
                                            Text(
                                              data[Index].address,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  letterSpacing: 2),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }else{
                              return Container();
                            }

                          });
                    } else {
                      return Center(child: Text("No data Founded"));
                    }
                }
              }),
        ),
      ),
    );
  }
}
