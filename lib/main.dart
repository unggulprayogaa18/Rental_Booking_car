import 'package:e_carnisa/screen/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:e_carnisa/showroom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_carnisa/autenticationdb/cekdata.dart';
import 'package:e_carnisa/car_bookingdb/cek_data.dart';

void main() {
  runApp(MyApp());
  checkData();
  checkCarBookings();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.mulishTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginSignupScreen(),
    );
  }
}