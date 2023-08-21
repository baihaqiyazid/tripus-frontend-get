import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String url = "http://192.168.100.36:8000/api";
String urlImage = "http://192.168.100.36:8000/";

Color backgroundColor = Color(0xffFFFFFF);
Color textPrimaryColor = Color(0xff191D21);
Color textSecondaryColor = Color(0xff656F77);
Color textButtonSecondaryColor = Color(0xff2F80ED);
Color textHintColor = Color(0xffB5B5B5);
Color bottomNavigationColor = Color(0xff4F4F4F);
Color containerPostColor = Color(0xffF5F5F5);

TextStyle primaryTextStyle = GoogleFonts.nunito(
  color: textPrimaryColor,
);

TextStyle primaryTextStylePlusJakartaSans = GoogleFonts.plusJakartaSans(
  color: textPrimaryColor,
);

TextStyle secondaryTextStyle = GoogleFonts.nunito(
  color: textSecondaryColor,
);

TextStyle buttonPrimaryTextStyle = GoogleFonts.nunito(
  color: backgroundColor,
);

TextStyle buttonSecondaryTextStyle = GoogleFonts.nunito(
  color: textButtonSecondaryColor,
);

TextStyle hintTextStyle = GoogleFonts.nunito(
  color: textHintColor,
);

FontWeight semibold = FontWeight.w600;
FontWeight medium = FontWeight.w500;
FontWeight extraBold = FontWeight.w800;
