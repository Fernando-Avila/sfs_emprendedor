import 'package:flutter/material.dart';

class EstiloApp {
  static const MaterialColor primaryblue =
      MaterialColor(_primarioPrimaryValue, <int, Color>{
    900: Color.fromARGB(90, 0, 23, 92),
    1000: Color(_primarioPrimaryValue),
  });
  static const int _primarioPrimaryValue = 0xFF00175C;

  static const MaterialColor primarypink =
      MaterialColor(_primarypinkValue, <int, Color>{
    1000: Color(_primarypinkValue),
  });
  static const int _primarypinkValue = 0xFFE3355C;

  static const MaterialColor primarypurple =
      MaterialColor(_primarypurpleValue, <int, Color>{
    1000: Color(_primarypurpleValue),
  });
  static const int _primarypurpleValue = 0xFFB434AC;

  static const MaterialColor colorwhite =
      MaterialColor(_colorwhiteValue, <int, Color>{
    1000: Color(_colorwhiteValue),
  });
  static const int _colorwhiteValue = 0xFFFFFFFF;

  static const MaterialColor colorblack =
      MaterialColor(_colorblackValue, <int, Color>{
    1000: Color(_colorblackValue),
  });
  static const int _colorblackValue = 0xFF000000;

  static const LinearGradient horizontalgradientpurplepink = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment(0.0, 1.0),
    colors: <Color>[
      EstiloApp.primarypurple,
      EstiloApp.primarypink,
    ],
  );

  static const LinearGradient horizontalgradientblue = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment(0.0, 1.0),
    colors: <Color>[
      EstiloApp.primaryblue,
      EstiloApp.primaryblue,
    ],
  );
  static const LinearGradient verticalgradientwhite = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: <Color>[
      EstiloApp.colorwhite,
      Color.fromARGB(10, 255, 255, 255),
    ],
  );
  static const LinearGradient horizontalgradienttransparent = LinearGradient(
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

  static const LinearGradient horizontalgradientmediumtransparent =
      LinearGradient(
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
      errorStyle: const TextStyle(
          color: EstiloApp.colorblack, fontSize: 8, height: 0.2),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: EstiloApp.primarypurple),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: EstiloApp.primarypurple),
      ),
      label: widget,
    );
  }
}
