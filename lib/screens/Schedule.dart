import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointments/constants.dart';
import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AppointmentDetailProvider, LoginPatientProvider>(
      builder: (context, appointmentDetail, user, _) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Constants.primaryBgColor,
          title: Text(
            'Schedule Lists',
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
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: FutureBuilder<List<AppointmentDetailModel>>(
              future: appointmentDetail.getAppointmentDetail(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(
                        color: Constants.primaryBgColor,
                      ),
                    );
                  default:
                    if (snapshot.data != null) {
                      List<AppointmentDetailModel> data = snapshot.data!;
                      List<AppointmentDetailModel> appointmentDetailModel = data
                          .where(
                              (element) => element.patient_id == user.user!.id)
                          .toList();
                      bool hasFilteringAppointmentDetail = data.any(
                          (element) => element.patient_id == user.user!.id);
                      if (hasFilteringAppointmentDetail) {
                        return ListView.builder(
                            itemCount: appointmentDetailModel.length,
                            itemBuilder: (context, Index) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(2, 6),
                                                blurRadius: 0.5,
                                                spreadRadius: 0.5,
                                                color: Constants.primaryBgColor)
                                          ]),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: 160,
                                                  height: 160,
                                                  decoration: BoxDecoration(
                                                    color: Constants
                                                        .primaryBgColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          appointmentDetailModel[
                                                                  Index]
                                                              .doctor_image,
                                                      fit: BoxFit.cover,
                                                      width: 80,
                                                      height: 80,
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
                                                    'Dr.${"${appointmentDetailModel[Index].doctor_fname} ${appointmentDetailModel[Index].doctor_lname}"}',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 2,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Gap(7),
                                                  Text(
                                                    appointmentDetailModel[
                                                            Index]
                                                        .doctor_speciality,
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 2),
                                                  ),
                                                  Gap(7),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Gap(5),
                                                      Text(
                                                        appointmentDetailModel[
                                                                Index]
                                                            .appointment_status,
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          letterSpacing: 2,
                                                          color: appointmentDetailModel[
                                                                          Index]
                                                                      .appointment_status ==
                                                                  'completed'
                                                              ? Colors.blue
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Gap(7),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.update,
                                                        color: Colors.blue,
                                                        size: 20,
                                                      ),
                                                      Gap(5),
                                                      Text(
                                                        appointmentDetailModel[
                                                        Index]
                                                            .date,
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
                                          Gap(7),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Gap(7),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.view_day_outlined,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  Gap(5),
                                                  Text(
                                                    appointmentDetailModel[
                                                            Index]
                                                        .day,
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 2),
                                                  ),
                                                ],
                                              ),
                                              Gap(20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.timer,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  Gap(5),
                                                  Text(
                                                    appointmentDetailModel[
                                                            Index]
                                                        .time,
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
                                    ),
                                  ],
                                ),
                              );
                            });
                      }

                      return Container();
                    } else {
                      return Container();
                    }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
