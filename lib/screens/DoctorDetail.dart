import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointments/CustomStyle.dart';
import 'package:doctor_appointments/constants.dart';
import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/providers/providers.dart';
import 'package:doctor_appointments/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DoctorDetail extends StatefulWidget {
  final DoctorModel doctorModel;

  const DoctorDetail({super.key, required this.doctorModel});

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorScheduleProvider>(
      builder: (context, doctorSchedule, _) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            'Doctor Detail',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              color: Colors.black,
              letterSpacing: 1.5,
            ),
          ),
          actions: [
            FutureBuilder<List<DoctorScheduleModel>>(
              future: doctorSchedule.getDoctorSchedule(),
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
                      List<DoctorScheduleModel> data = snapshot.data!;
                      bool hasMatchingSchedule = data.any(
                          (element) => element.doc_id == widget.doctorModel.id);
                      if (hasMatchingSchedule) {
                        return Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return DoctorBooking(
                                      doctorModel: widget.doctorModel,
                                    );
                                  });
                            },
                            child: Container(
                              color: Constants.primaryBgColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.app_registration,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  Gap(10),
                                  Text(
                                    'Book Now',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                }
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: double.infinity,
          height: double.infinity,
          color: Color(0xffffffff),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        child: Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: CachedNetworkImageProvider(
                                widget.doctorModel.image),
                          ),
                        ),
                      ),
                      Gap(15),
                      Container(
                        width: 190,
                        height: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dr.${widget.doctorModel.fname} ${widget.doctorModel.lname}",
                              style: CustomStyles.medium,
                            ),
                            Gap(10),
                            Text(
                              "${widget.doctorModel.speciality}",
                              style: CustomStyles.small,
                            ),
                            Gap(10),
                            Row(
                              children: [
                                Icon(
                                  Icons.verified,
                                  color: widget.doctorModel.status == 'verified'
                                      ? Colors.blue
                                      : Colors.red,
                                  size: 20,
                                ),
                                Gap(4),
                                Text(
                                  widget.doctorModel.status,
                                  style: CustomStyles.small,
                                )
                              ],
                            ),
                            Gap(10),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: Constants.primaryBgColor,
                                ),
                                Gap(4),
                                Text(
                                  widget.doctorModel.address,
                                  style: CustomStyles.small,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Gap(10),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.email,
                          size: 20,
                          color: Colors.white,
                        )),
                    Gap(10),
                    Text(
                      '${widget.doctorModel.email}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.person,
                              size: 20,
                              color: Colors.white,
                            )),
                        Gap(10),
                        Column(
                          children: [
                            Text(
                              'Patients',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                                letterSpacing: 1.5,
                              ),
                            ),
                            Text(
                              '7,500 + ',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.work_history,
                              size: 20,
                              color: Colors.white,
                            )),
                        Gap(10),
                        Column(
                          children: [
                            Text(
                              '${widget.doctorModel.experience}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Gap(5),
                Divider(
                  color: Colors.grey.shade500,
                  thickness: 0.5,
                ),
                Gap(5),
                Text(
                  widget.doctorModel.description,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                      letterSpacing: 1.9,
                      height: 1.5),
                  textAlign: TextAlign.justify,
                ),
                Gap(10),
                Container(
                    width: double.infinity,
                    child: Text(
                      'Working Hours',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                        letterSpacing: 1.5,
                      ),
                    )),
                Gap(5),
                Divider(
                  color: Colors.grey.shade500,
                  thickness: 0.5,
                ),
                Container(
                  child: FutureBuilder<List<DoctorScheduleModel>>(
                    future: doctorSchedule.getDoctorSchedule(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(
                              color: Constants.primaryBgColor,
                            ),
                          );
                        default:
                          if (snapshot.hasData) {
                            List<DoctorScheduleModel> data = snapshot.data!;
                            if (data.any(
                                (e) => widget.doctorModel.id == e.doc_id)) {
                              return DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      'Day',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'From Time',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'To Time',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: data
                                    .where((e) =>
                                        widget.doctorModel.id == e.doc_id)
                                    .map((e) {
                                  return DataRow(cells: [
                                    DataCell(
                                      Text(
                                        e.day,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        e.from_time,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        e.to_time,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ),
                                  ]);
                                }).toList(),
                              );
                            } else {
                              return Center(
                                child: Text(
                                    'This doctor does not have a schedule time.'),
                              );
                            }
                          } else {
                            return Center(
                              child: Text('Failed to load data'),
                            );
                          }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
