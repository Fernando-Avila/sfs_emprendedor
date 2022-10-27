import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

Widget H1(String text, MaterialColor c, TextAlign align, String fontfamily,
    FontWeight fontWeight, FontStyle fontStyle) {
  return Text(text,
      textAlign: align,
      style: TextStyle(
          fontFamily: fontfamily,
          fontStyle: fontStyle,
          color: c,
          fontSize: 32,
          fontWeight: fontWeight));
}

Widget H2(String text, MaterialColor c, TextAlign align, String fontfamily,
    FontWeight fontWeight, FontStyle fontStyle) {
  return AutoSizeText(text,
      //  textAlign: align,
      style: TextStyle(
          fontFamily: fontfamily,
          fontStyle: fontStyle,
          color: c,
          fontSize: 26,
          fontWeight: fontWeight));
}

Widget H3(String text, MaterialColor c, TextAlign align, String fontfamily,
    FontWeight fontWeight, FontStyle fontStyle) {
  return AutoSizeText(text,
      textAlign: align,
      style: TextStyle(
          fontFamily: fontfamily,
          fontStyle: fontStyle,
          color: c,
          fontSize: 22,
          fontWeight: fontWeight));
}

Widget H4(String text, MaterialColor c, TextAlign align, String fontfamily,
    FontWeight fontWeight, FontStyle fontStyle) {
  return AutoSizeText(text,
      textAlign: align,
      style: TextStyle(
          fontFamily: fontfamily,
          fontStyle: fontStyle,
          color: c,
          fontSize: 20,
          fontWeight: fontWeight));
}

Widget H5(String text, MaterialColor c, TextAlign align, String fontfamily,
    FontWeight fontWeight, FontStyle fontStyle) {
  return AutoSizeText(text,
      textAlign: align,
      style: TextStyle(
          fontFamily: fontfamily,
          fontStyle: fontStyle,
          color: c,
          fontSize: 18,
          fontWeight: fontWeight));
}

Widget H0(String text, MaterialColor c, TextAlign align, String fontfamily,
    FontWeight fontWeight) {
  return Text(text,
      textAlign: align,
      style: TextStyle(
          fontFamily: fontfamily,
          color: c,
          fontSize: 42,
          fontWeight: fontWeight));
}

Widget p1(String text, MaterialColor c, TextAlign align, String fontfamily,
    FontWeight fontWeight, FontStyle fontStyle) {
  return AutoSizeText(text,
      textAlign: align,
      style: TextStyle(
          fontFamily: fontfamily,
          color: c,
          fontStyle: fontStyle,
          fontSize: 16,
          fontWeight: fontWeight));
}

Widget p2(String text, MaterialColor c, TextAlign align, String fontfamily,
    FontWeight fontWeight, FontStyle fontStyle) {
  return Text(text,
      textAlign: align,
      style: TextStyle(
          fontFamily: fontfamily,
          color: c,
          fontStyle: fontStyle,
          fontSize: 14,
          fontWeight: fontWeight));
}

Widget p3(String text, MaterialColor c, TextAlign align, String fontfamily,
    FontWeight fontWeight) {
  return AutoSizeText(text,
      textAlign: align,
      style: TextStyle(
          fontFamily: fontfamily,
          color: c,
          fontSize: 12,
          fontWeight: fontWeight));
}

Widget p4(String text, MaterialColor c, TextAlign align, String fontfamily,
    FontWeight fontWeight) {
  return Text(text,
      textAlign: align,
      style: TextStyle(
          fontFamily: fontfamily,
          color: c,
          fontSize: 11,
          fontWeight: fontWeight));
}
