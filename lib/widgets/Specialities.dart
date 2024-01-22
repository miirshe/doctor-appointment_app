import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointments/constants.dart';
import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/screens/DoctorsSpecialities.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Specialities extends StatefulWidget {
  final SpecialitiesModel? specialitiesModel;

  const Specialities({super.key, required this.specialitiesModel});

  @override
  State<Specialities> createState() => _SpecialitiesState();
}

class _SpecialitiesState extends State<Specialities> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_){
            return  DoctorsSpecialities(speciality: widget.specialitiesModel!.speciality,);
          }));
        },
        child: Container(
          width: 120,
          height: 185,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                width: 35,
                height: 35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(imageUrl: widget.specialitiesModel!.image,fit: BoxFit.cover,)
                ),
              ),
              Gap(5),
              Text(
                widget.specialitiesModel!.speciality,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                  letterSpacing: 1.5,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
