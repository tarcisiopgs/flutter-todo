import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:todo/app/pages/home_page.dart';
import 'package:todo/core/ui/colors.dart';

class AppWidget extends StatelessWidget {
  final String title;

  const AppWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: appBackgroundColor,
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const HomePage(),
    );
  }
}
