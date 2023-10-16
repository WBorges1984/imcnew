import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imcnew/page/dashboard_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        textTheme: GoogleFonts.deliusTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const DashboardPage(),
    );
  }
}
