import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointments/constants.dart';
import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SpecialityLists extends StatefulWidget {
  const SpecialityLists({super.key});

  @override
  State<SpecialityLists> createState() => _SpecialityListsState();
}

class _SpecialityListsState extends State<SpecialityLists> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SpecialitiesProvider>(
      builder: (context, speciality, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.primaryBgColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Specialities Lists ',
            style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: FutureBuilder<List<SpecialitiesModel>>(
            future: speciality.getSpecialities(),
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
                    List<SpecialitiesModel> data = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 28,
                          mainAxisSpacing: 25),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                offset: Offset(2, 6),
                                blurRadius:0.5,
                                color: Constants.primaryBgColor
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: data[index].image,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              Gap(10),
                              Text(
                                '${data[index].speciality}',
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    letterSpacing: 2),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('Not Found Any Data'),
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
