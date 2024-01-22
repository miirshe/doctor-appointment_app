import 'package:doctor_appointments/constants.dart';
import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/providers/doctorProvider.dart';
import 'package:doctor_appointments/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DoctorBooking extends StatefulWidget {
  final DoctorModel doctorModel;

  const DoctorBooking({super.key, required this.doctorModel});

  @override
  State<DoctorBooking> createState() => _DoctorBookingState();
}

class _DoctorBookingState extends State<DoctorBooking> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController timeController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  String? description;
  String? date;
  String? currentDate;
  String? day;
  String? time;
  String? doc_id;
  String? pat_id;
  @override
  Widget build(BuildContext context) {
    return Consumer3<DoctorScheduleProvider, DoctorProvider,
        LoginPatientProvider>(
      builder: (context, doctorSchedule, doctors, user, _) => Container(
        width: double.infinity,
        height: 650,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            Text(
              'Book Now',
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                  color: Constants.primaryBgColor),
            ),
            Divider(
              color: Colors.grey.shade500,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(3),
                child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(10),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Date',style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.w500),),
                        ),
                        Gap(5),
                        Expanded(
                          child: FutureBuilder<List<DoctorScheduleModel>>(
                            future: doctorSchedule.getDoctorSchedule(),
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
                                    List<DoctorScheduleModel> data =
                                        snapshot.data!;
                                    List<DoctorScheduleModel> filteredData =
                                        data
                                            .where((element) =>
                                                element.doc_id ==
                                                widget.doctorModel.id)
                                            .toList();
                                    return DropdownButtonFormField(
                                      onSaved: (newVal) {
                                        if (newVal != null) {
                                          if (newVal.isNotEmpty) {
                                            currentDate = date;
                                          }
                                        }
                                        ;
                                      },
                                      validator: (newVal) {
                                        if (newVal != null) {
                                          if (newVal.isEmpty) {
                                            Text(
                                              'ate appointment is required',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 2),
                                            );
                                          }
                                        }
                                      },
                                      decoration: InputDecoration(
                                        fillColor: Color(0xffF0F0F0),
                                        filled: true,
                                        hintMaxLines: 5,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      value: date,
                                      hint: Text(
                                        'Select a date appointment',
                                        style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 2),
                                      ),
                                      items: filteredData
                                          .map<DropdownMenuItem<String>>(
                                              (data) {
                                        return DropdownMenuItem<String>(
                                          value: data.date,
                                          child: Text(data.date),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          date = value;
                                          DoctorScheduleModel? currentSchedule =
                                              data.firstWhere((element) =>
                                                  element.date == date);
                                          if (currentSchedule != null) {
                                            time = currentSchedule.from_time;
                                            day = currentSchedule.day;
                                            timeController.text = time ?? '';
                                            dayController.text = day ?? '';
                                            print('day,${day}');
                                          } else {
                                            print(
                                                'No schedule found for the selected date');
                                          }
                                        });
                                      },
                                    );
                                  } else {
                                    return Text('');
                                  }
                              }
                            },
                          ),
                        ),
                        Gap(5),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Day',style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.w500),),
                        ),
                        Gap(5),
                        TextFormField(
                          controller: dayController,
                          readOnly: true,
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF0F0F0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),

                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                          ),
                        ),
                        Gap(5),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Time',style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.w500),),
                        ),
                        Gap(5),
                        TextFormField(
                          controller: timeController,
                          readOnly: true,
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF0F0F0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),

                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                          ),
                        ),
                        Gap(5),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Description',style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.w500),),
                        ),
                        Gap(5),
                        TextFormField(
                          onSaved: (newVal) {
                            if (newVal != null) {
                              if (newVal.isNotEmpty) {
                                description = newVal;
                              } else {
                                Text(
                                  'description is required',
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 2),
                                );
                              }
                            }
                          },
                          maxLines: 3,
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2),
                          decoration: InputDecoration(
                            hintText: 'Enter Description',
                            filled: true,
                            fillColor: Color(0xffF0F0F0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                          ),
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: 150,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  decoration: BoxDecoration(
                                      color: Color(0xffF0F0F0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      'Close',
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 2,
                                          color:Constants.primaryBgColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              child: InkWell(
                                onTap: () {
                                  _formkey.currentState!.save();
                                  if (_formkey.currentState!.validate()) {
                                    doc_id = widget.doctorModel.id;
                                    pat_id = user.user!.id;
                                    Provider.of<DoctorBookingProvider>(context,listen: false).
                                    createDoctorBooking(date!, dayController.text , timeController.text , doc_id!, pat_id!, description!,context);
                                    print({date!, dayController.text , timeController.text , doc_id!, pat_id!, description!});
                                  }
                                },
                                child: Container(
                                  width: 150,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  decoration: BoxDecoration(
                                      color: Constants.primaryBgColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      'Save',
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 2,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
