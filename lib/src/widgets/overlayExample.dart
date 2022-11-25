import 'package:flutter/material.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

class OverlayExample extends StatelessWidget {
  const OverlayExample({
    Key? key,
    required this.title,
    required this.info,
    required this.date,
  }) : super(key: key);
  final String title;
  final String info;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  color: Colors.black.withAlpha(50),
                  padding: const EdgeInsets.all(20.0),
                  child: H5(title, EstiloApp.colorwhite, TextAlign.left,
                      'Montserrat', FontWeight.w500, FontStyle.normal)),
              IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                tooltip: 'Cerrar',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    color: Colors.black.withAlpha(50),
                    padding: EdgeInsets.all(20.0),
                    child: p1(info, EstiloApp.colorwhite, TextAlign.left,
                        'Montserrat', FontWeight.w500, FontStyle.normal)),
              ),
              Container(
                  color: Colors.black.withAlpha(50),
                  padding: EdgeInsets.all(20.0),
                  child: p2(datef(date), EstiloApp.colorwhite, TextAlign.left,
                      'Montserrat', FontWeight.w500, FontStyle.normal)),
            ],
          ),
        ],
      ),
    );
  }

  String datef(DateTime date) {
    String mes = '';
    switch (date.month) {
      case 1:
        mes = 'ENE';
        break;
      case 2:
        mes = 'FEB';
        break;
      case 3:
        mes = 'MAR';
        break;
      case 4:
        mes = 'ABR';
        break;
      case 5:
        mes = 'MAY';
        break;
      case 6:
        mes = 'JUN';
        break;
      case 7:
        mes = 'JUL';
        break;
      case 8:
        mes = 'AGO ';
        break;
      case 9:
        mes = 'SEP';
        break;
      case 10:
        mes = 'OCT';
        break;
      case 11:
        mes = 'NOV';
        break;
      case 12:
        mes = 'DIC';
        break;
      default:
    }
    return '${date.day}/$mes/${date.year}';
  }
}
