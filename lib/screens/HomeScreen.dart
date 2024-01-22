import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointments/constants.dart';
import 'package:doctor_appointments/models/models.dart';
import 'package:doctor_appointments/providers/providers.dart';
import 'package:doctor_appointments/screens/screens.dart';
import 'package:doctor_appointments/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<DoctorProvider, SpecialitiesProvider,
            LoginPatientProvider>(
        builder: (context, doctors, specialities, login, _) {
      final user = login.user;
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Constants.primaryBgColor,
          title: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CircleAvatar(
                radius: 20,
                child: CachedNetworkImage(
                  imageUrl: user?.image ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              "Hi ${user?.name ?? ''}",
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                letterSpacing: 1.5,
                height: 1.9,
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Colors.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 30),
                decoration: BoxDecoration(
                    color: Constants.primaryBgColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        'How do you feel today ?',
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    Gap(20),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: Icon(
                              Icons.search,
                              size: 25,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 13, vertical: 13),
                            hintText: 'Search Doctor..',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Specialities",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          letterSpacing: 1.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return SpecialityLists();
                            }),
                          );
                        },
                        child: Text(
                          'See All',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 95,
                  child: FutureBuilder<List<SpecialitiesModel>>(
                      future: specialities.getSpecialities(),
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
                              List<SpecialitiesModel> data = snapshot.data!;
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Specialities(
                                          specialitiesModel: data[index],
                                        ));
                                  });
                            } else {
                              return Center(
                                  child: Text('Not found any  data...'));
                            }
                        }
                      }),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Doctors",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                        letterSpacing: 1.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) {
                            return DoctorsLists();
                          }),
                        );
                      },
                      child: Text(
                        'See All',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          letterSpacing: 1.5,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                width: double.infinity,
                height: 245,
                child: FutureBuilder<List<DoctorModel>>(
                    future: doctors.getDoctors(),
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
                            List<DoctorModel> data = snapshot.data!;
                            print(data.length);
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return DoctorCards(doctors: data[index]);
                              },
                            );
                          } else {
                            return Center(
                                child: Text('Not found any  data...'));
                          }
                      }
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
