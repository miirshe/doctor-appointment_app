import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointments/constants.dart';
import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/screens/DoctorDetail.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoctorCards extends StatefulWidget {
  final DoctorModel? doctors;

  const DoctorCards({super.key, required this.doctors});

  @override
  State<DoctorCards> createState() => _DoctorCardsState();
}

class _DoctorCardsState extends State<DoctorCards> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: 
      InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorDetail(doctorModel: widget.doctors!)),);
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: Offset(2, 6),
                    blurRadius: 4,
                    spreadRadius: 2,
                    color: Colors.black.withOpacity(0.1))
              ]),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Color(0xffE8F6FB),
                  width: double.infinity,
                  margin: EdgeInsets.all(8),
                  child: CachedNetworkImage(
                    imageUrl: widget.doctors!.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        widget.doctors!.status == 'verified'
                            ? Icon(
                                Icons.verified,
                                color: Colors.blue,
                              )
                            : Icon(
                                Icons.verified,
                                color: Colors.red,
                              ),
                        SizedBox(width: 4,),
                        Text(
                          widget.doctors!.status,
                          style: widget.doctors!.status == 'verified'
                              ? TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  letterSpacing: 1.5)
                              : TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  letterSpacing: 1.5),
                        )
                      ],
                    ),
                    SizedBox(height: 4,),
                    Container(
                      margin: EdgeInsets.only(left: 4),
                      child: Text(
                        'Dr. ${widget.doctors!.fname + " " + widget.doctors!.lname}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 4,),
                    Container(
                      margin: EdgeInsets.only(left: 3),
                      child: Text(
                        widget.doctors!.speciality,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey.shade800,
                            letterSpacing: 2),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
