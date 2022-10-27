import 'package:flutter/material.dart';

class EstiloApp {
  static MaterialColor primaryblue =
      MaterialColor(_primarioPrimaryValue, <int, Color>{
    900: Color.fromARGB(90, 0, 23, 92),
    1000: Color(_primarioPrimaryValue),
  });
  static int _primarioPrimaryValue = 0xFF00175C;

  static MaterialColor primarypink =
      MaterialColor(_primarypinkValue, <int, Color>{
    1000: Color(_primarypinkValue),
  });
  static int _primarypinkValue = 0xFFE3355C;

  static MaterialColor primarypurple =
      MaterialColor(_primarypurpleValue, <int, Color>{
    1000: Color(_primarypurpleValue),
  });
  static int _primarypurpleValue = 0xFFB434AC;

  static MaterialColor colorwhite =
      MaterialColor(_colorwhiteValue, <int, Color>{
    1000: Color(_colorwhiteValue),
  });
  static int _colorwhiteValue = 0xFFFFFFFF;

  static MaterialColor colorblack =
      MaterialColor(_colorblackValue, <int, Color>{
    1000: Color(_colorblackValue),
  });
  static int _colorblackValue = 0xFF000000;

  static LinearGradient horizontalgradientpurplepink = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment(0.0, 1.0),
    colors: <Color>[
      EstiloApp.primarypurple,
      EstiloApp.primarypink,
    ],
  );

  static LinearGradient horizontalgradientpurplepinknotify = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment(0.0, 1.0),
    colors: <Color>[
      Color.fromARGB(160, 180, 52, 171),
      Color.fromARGB(113, 227, 53, 91),
    ],
  );

  static LinearGradient horizontalgradientblue = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment(0.0, 1.0),
    colors: <Color>[
      EstiloApp.primaryblue,
      EstiloApp.primaryblue,
    ],
  );
  static LinearGradient verticalgradientwhite = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: <Color>[
      EstiloApp.colorwhite,
      Color.fromARGB(10, 255, 255, 255),
    ],
  );
  static LinearGradient horizontalgradienttransparent = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [
      0.1,
      0.4,
      0.6,
      0.9,
    ],
    colors: [
      Color.fromARGB(160, 180, 52, 171),
      Color.fromARGB(113, 227, 53, 91),
      Color.fromARGB(76, 227, 53, 91),
      Colors.transparent,
    ],
  );

  static LinearGradient horizontalgradientmediumtransparent = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [
      0.1,
      0.3,
      0.5,
      0.8,
    ],
    colors: [
      EstiloApp.primarypink,
      EstiloApp.primarypink,
      EstiloApp.primarypink,
      Colors.transparent,
    ],
  );
  static BoxDecoration decorationBoxwhite = BoxDecoration(
      color: EstiloApp.colorwhite,
      boxShadow: kElevationToShadow[9],
      borderRadius: BorderRadius.circular(20));

  static InputDecoration inputdecoration(Widget widget) {
    return InputDecoration(
      errorStyle:
          TextStyle(color: EstiloApp.colorblack, fontSize: 8, height: 0.2),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: EstiloApp.primarypurple),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: EstiloApp.primarypurple),
      ),
      label: widget,
    );
  }
}
