import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kTextDark = Colors.black;
Color kTextLight = Colors.white;

Color secondaryColor = const Color(0xFFE1E1E2);

class Styles {
  static const edgeInsetAll16 = EdgeInsets.all(16);
  static const edgeInsetAll10 = EdgeInsets.all(10);
  static const edgeInsetAll7 = EdgeInsets.all(7);
  static const edgeInsetAll5 = EdgeInsets.all(5);
  static const edgeInsetAll3 = EdgeInsets.all(3);
  static const edgeInsetAll0 = EdgeInsets.zero;
  static const edgeInsetHorizontal16 = EdgeInsets.symmetric(horizontal: 16);
  static const edgeInsetVertical5 = EdgeInsets.symmetric(vertical: 5);
  static const edgeInsetHorizontal5 = EdgeInsets.symmetric(horizontal: 5);
  static const edgeInsetVertical16 = EdgeInsets.symmetric(vertical: 16);
  static const edgeInsetVertical10 = EdgeInsets.symmetric(vertical: 10);
  static const edgeInsetHorizontal10 = EdgeInsets.symmetric(horizontal: 10);
  static const edgeInsetHorizontal10Vertical5 = EdgeInsets.symmetric(horizontal: 10, vertical: 5);
  static const edgeInsetSymmetric10 = EdgeInsets.symmetric(horizontal: 10, vertical: 10);
  static const edgeInsetSymmetric8 = EdgeInsets.symmetric(horizontal: 8, vertical: 8);
  static const edgeInsetSymmetric5 = EdgeInsets.symmetric(horizontal: 5, vertical: 5);

  static const edgeInsetHorizontal16Top10 = EdgeInsets.only(left: 16, right: 16, top: 10);

  static const alertContentPadding = EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 5);

  static const altAlertContentPadding = EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12);

  static const pickerAlertContentPadding = EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 6);

  static const signAlertContentPadding = EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12);

  static const double smallButtonSplashRadius = 18;

  static const formFieldMargin = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 7,
  );

  static const editFormFieldMargin = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  static const modalBottomSheetShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
    ),
  );

  static const modalBottomSheetContainerMargin = EdgeInsets.only(left: 10, right: 10, bottom: 10);
  static const modalBottomSheetContainerPadding = EdgeInsets.only(left: 10, right: 10, top: 10);

  static double getIconSizeForItemPopupMenuFilter(bool forDefaultIcons) {
    return forDefaultIcons ? 24 : 18;
  }

  static OutlineInputBorder outlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      gapPadding: 5,
    );
  }

  static const expandedBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(15),
    topRight: Radius.circular(15),
  );

  static const cardItemDetailShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(20),
      topLeft: Radius.circular(20),
    ),
  );

  static const formFieldBorder = OutlineInputBorder(
    borderSide: BorderSide(),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static const editFormFieldBorder = UnderlineInputBorder(
    borderSide: BorderSide(width: 1.5, color: Colors.grey),
  );

  static const onboardingFieldBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  static const formFieldPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 5);

  static const editFormFieldPadding = EdgeInsets.symmetric(horizontal: 0, vertical: 7);

  static const double materialEventCardHeight = 200;

  static const double cardThreeElevation = 3;
  static const double cardTenElevation = 10;

  static const circularBorderRadius5 = BorderRadius.all(Radius.circular(5));

  static const circularBorderRadius7 = BorderRadius.all(Radius.circular(7));

  static const mainCardBorderRadius = BorderRadius.all(Radius.circular(10));

  static const settingsCardBorderRadius = BorderRadius.all(Radius.circular(5));

  static const alertDialogBorderRadius = BorderRadius.all(Radius.circular(5));

  static const resourceCardBorderRadius = BorderRadius.only(
    topRight: Radius.circular(10),
    topLeft: Radius.circular(10),
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  );

  static const buggyCardBorderRadius = BorderRadius.only(
    topRight: Radius.circular(10),
    topLeft: Radius.circular(10),
    bottomLeft: Radius.circular(35),
    bottomRight: Radius.circular(35),
  );

  static const circleTapBorderRadius = BorderRadius.all(Radius.circular(20));

  static const RoundedRectangleBorder mainCardShape = RoundedRectangleBorder(borderRadius: mainCardBorderRadius);

  static const RoundedRectangleBorder activityCardShape = RoundedRectangleBorder(borderRadius: circularBorderRadius7);

  static const RoundedRectangleBorder settingsCardShape = RoundedRectangleBorder(borderRadius: settingsCardBorderRadius);

  static const RoundedRectangleBorder resourceCardShape = RoundedRectangleBorder(borderRadius: resourceCardBorderRadius);

  static const RoundedRectangleBorder alertDialogShape = RoundedRectangleBorder(borderRadius: alertDialogBorderRadius);
}

class CseanMobileTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.lato(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: kTextDark,
    ),
    bodyText2: GoogleFonts.lato(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: kTextDark,
    ),
    headline1: GoogleFonts.lato(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: kTextDark,
    ),
    headline2: GoogleFonts.lato(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
      color: kTextDark,
    ),
    headline3: GoogleFonts.lato(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: kTextDark,
    ),
    headline4: GoogleFonts.lato(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: kTextDark,
    ),
    headline5: GoogleFonts.lato(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      color: kTextDark,
    ),
    headline6: GoogleFonts.lato(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: kTextDark,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.lato(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: kTextLight,
    ),
    bodyText2: GoogleFonts.lato(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: kTextLight,
    ),
    headline1: GoogleFonts.lato(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: kTextLight,
    ),
    headline2: GoogleFonts.lato(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
      color: kTextLight,
    ),
    headline3: GoogleFonts.lato(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: kTextLight,
    ),
    headline4: GoogleFonts.lato(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: kTextLight,
    ),
    headline5: GoogleFonts.lato(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      color: kTextLight,
    ),
    headline6: GoogleFonts.lato(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: kTextLight,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      primarySwatch: Colors.green,
      dividerColor: const Color(0xFFF9F9F9),
      bottomAppBarColor: const Color(0xFFF1F1F1),
      canvasColor: Colors.grey[50],
      cardColor: Colors.white,
      shadowColor: const Color(0xFFC3EDDA),
      indicatorColor: Colors.black,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF1F1F1),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      textTheme: lightTextTheme,
      primaryColor: const Color(0xFF015E1F),
      colorScheme: const ColorScheme.light(primary: Color(0xFF015E1F))
          .copyWith(secondary: const Color(0xFF57C7A0)),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      primarySwatch: Colors.green,
      dividerColor: Colors.black,
      bottomAppBarColor: const Color(0xFF272C2F),
      canvasColor: Colors.black54,
      cardColor: Colors.grey.shade900,
      shadowColor: const Color(0xFF192C31),
      indicatorColor: Colors.white,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF000000),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      textTheme: darkTextTheme,
      primaryColor: const Color(0xFF015E1F),
      colorScheme: const ColorScheme.dark(primary: Color(0xFF015E1F))
          .copyWith(secondary: const Color(0xFF57C7A0)),
    );
  }
}
