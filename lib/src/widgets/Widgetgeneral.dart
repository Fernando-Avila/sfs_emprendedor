import 'package:flutter/material.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

Widget inf(String img, String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          img,
          width: MediaQuery.of(context).size.width * 0.08,
        ),
        SizedBox(width: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: p3(title, EstiloApp.primaryblue, TextAlign.left, 'Montserrat',
              FontWeight.w500),
        )
      ],
    ),
  );
}
