import 'package:doctor_appointments/providers/providers.dart';
import 'package:doctor_appointments/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
void main() async {
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SpecialitiesProvider()),
        ChangeNotifierProvider<DoctorProvider>(create: (_) => DoctorProvider()),
        ChangeNotifierProvider<DoctorScheduleProvider>(
            create: (_) => DoctorScheduleProvider()),
        ChangeNotifierProvider<RegisterProvider>(create: (_) => RegisterProvider()),
        ChangeNotifierProvider<LoginPatientProvider>(create: (_) => LoginPatientProvider()),
        ChangeNotifierProvider<DiagnosesProvider>(create: (_) => DiagnosesProvider()),
        ChangeNotifierProvider<DoctorBookingProvider>(create: (_) => DoctorBookingProvider()),
        ChangeNotifierProvider<AppointmentDetailProvider>(create: (_) => AppointmentDetailProvider())

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff2563EB),
          scaffoldBackgroundColor: Color(0xffF7F8FA)),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardScreen(),
        '/home': (context) => Home(),
        '/schedule': (context) => Schedule(),
        '/login': (context) => Login(),
        '/forget_password': (context) => ForgetPassword(),
        '/register': (context) => Register(),
        '/patient_profile':(context) => PatientProfile()
      },
    );
  }
}
