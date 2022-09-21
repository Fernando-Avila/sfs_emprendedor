import 'package:flutter/material.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';

class button extends StatelessWidget {
  final Function() metod;
  final Widget widget;
  final double width;
  final double height;
  final LinearGradient gradient;
  const button(this.metod, this.widget, this.width, this.height, this.gradient);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(60),
      onTap: metod,
      child: Ink(
        width: width,
        height: height,
        padding: EdgeInsets.all(5),
        child: Center(child: widget),
        decoration: BoxDecoration(
            boxShadow: kElevationToShadow[3],
            gradient: gradient,
            borderRadius: BorderRadius.circular(60)),
      ),
    );
  }
}
