import 'package:flutter/material.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

class Dropdown extends StatelessWidget {
  final List<String> list;
  final TextEditingController textediting;
  final String title;
  final MaterialColor color;
  final double width;
  final Function() metodo;
  Dropdown(this.list, this.textediting, this.color, this.width, this.title,
      this.metodo);
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: p1(title, EstiloApp.colorblack, TextAlign.center,
                  'Montserrat', FontWeight.w400, FontStyle.normal)),
          Container(
            width: MediaQuery.of(context).size.width * width,
            // padding: EdgeInsets.symmetric(horizontal: 10),
            // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: EstiloApp.colorwhite,
                border: Border.all(width: 0.02),
                boxShadow: kElevationToShadow[3]),
            child: DropdownButton<String>(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              dropdownColor: color,
              items: list.map((String a) {
                return DropdownMenuItem(value: a, child: Text(a));
              }).toList(),
              onChanged: (value) {
                metodo;
                print('as');
                textediting.text = value!;
              },
              hint: SizedBox(
                width: (MediaQuery.of(context).size.width * width) - 60,
                child: TextFormField(
                  validator: (value) {
                    if (value == 'Seleccione' || value == null || value == '') {
                      return 'Campo requerido';
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: EstiloApp.primaryblue,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                  readOnly: true,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                        color: EstiloApp.colorblack, fontSize: 10, height: 0.3),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide:
                          BorderSide(width: 1, color: EstiloApp.primarypink),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide:
                          BorderSide(width: 1, color: EstiloApp.primarypink),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide:
                          BorderSide(width: 1, color: EstiloApp.primarypurple),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide:
                          BorderSide(width: 1, color: EstiloApp.primarypink),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide:
                          BorderSide(width: 1, color: EstiloApp.primarypurple),
                    ),
                  ),
                  controller: textediting,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String? validator(String value) {
  if (value == null || value.isEmpty) {
    return 'Campo obligatorio';
  }
  return null;
}

class Textfield extends StatelessWidget {
  final String placeholder;
  final TextInputType tipoTexto;
  final TextEditingController controlador;
  final TextCapitalization textCapitalization;
  final bool readonly;
  final Function() metodo;
  final Widget? widget;
  final String? Function(String?) validator;
  Textfield(
      this.placeholder,
      this.tipoTexto,
      this.controlador,
      this.textCapitalization,
      this.readonly,
      this.metodo,
      this.widget,
      this.validator);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),

        /*decoration: BoxDecoration(
            color: EstiloApp.colorWhite,
            border: Border.all(width: 0.02),
            boxShadow: kElevationToShadow[3]),*/
        child: TextFormField(
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onTap: metodo,
          keyboardType: tipoTexto,
          textCapitalization: textCapitalization,
          controller: controlador,
          autofocus: false,
          readOnly: readonly,
          cursorColor: EstiloApp.primaryblue,
          decoration: InputDecoration(
              prefixIcon: widget ?? null,
              errorStyle: TextStyle(
                  color: EstiloApp.colorblack, fontSize: 10, height: 0.3),
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
                borderSide:
                    BorderSide(width: 1, color: EstiloApp.primarypurple),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1, color: EstiloApp.primarypink),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide:
                    BorderSide(width: 1, color: EstiloApp.primarypurple),
              ),
              label: p1(placeholder, EstiloApp.colorblack, TextAlign.center,
                  'Montserrat', FontWeight.w400, FontStyle.normal)),
        ));
  }
}

class Textfieldml extends StatelessWidget {
  final String placeholder;
  final TextEditingController controlador;
  final TextCapitalization textCapitalization;
  final bool readonly;
  final Function() metodo;
  final Widget? widget;
  final String? Function(String?) validator;
  Textfieldml(this.placeholder, this.controlador, this.textCapitalization,
      this.readonly, this.metodo, this.widget, this.validator);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        /*decoration: BoxDecoration(
            color: EstiloApp.colorWhite,
            border: Border.all(width: 0.02),
            boxShadow: kElevationToShadow[3]),*/
        child: TextFormField(
          // textInputAction: TextInputAction.next,

          textInputAction: TextInputAction.newline,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onTap: metodo,
          cursorColor: EstiloApp.primaryblue,
          minLines: 1,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textCapitalization: textCapitalization,
          controller: controlador,
          autofocus: false,
          readOnly: readonly,
          decoration: InputDecoration(
            prefixIcon: widget ?? null,
            errorStyle: TextStyle(
                color: EstiloApp.colorblack, fontSize: 8, height: 0.1),
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
            label: p1(placeholder, EstiloApp.colorblack, TextAlign.center,
                'Montserrat', FontWeight.w400, FontStyle.normal),
          ),
        ));
  }
}

class BtnWhite extends StatelessWidget {
  final Function() metod;
  final Widget widget;
  final double width;
  final double height;
  BtnWhite(
      {Key? key,
      required this.metod,
      required this.widget,
      required this.width,
      required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(60),
      splashColor: EstiloApp.primarypink,
      onTap: metod,
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: height,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: EstiloApp.decorationBoxwhite,
        child: Center(child: widget),
      ),
    );
  }
}

class Parraftext extends StatelessWidget {
  final Widget widget;
  final double width;
  final double height;
  Parraftext(
      {Key? key,
      required this.widget,
      required this.width,
      required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            boxShadow: kElevationToShadow[2],
            color: EstiloApp.colorwhite,
            borderRadius: BorderRadius.circular(10)),
        child: widget);
  }
}

class BtnDegraded extends StatelessWidget {
  final Function() metod;
  final Widget widget;
  final double width;
  final double height;
  BtnDegraded(
      {Key? key,
      required this.metod,
      required this.widget,
      required this.width,
      required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(60),
      splashColor: EstiloApp.primarypink,
      onTap: metod,
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: height,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            gradient: EstiloApp.horizontalgradientpurplepink,
            boxShadow: kElevationToShadow[9],
            borderRadius: BorderRadius.circular(60)),
        child: Center(child: widget),
      ),
    );
  }
}

class BtnBlue extends StatelessWidget {
  final Function() metod;
  final Widget widget;
  final double width;
  final double height;
  BtnBlue(
      {Key? key,
      required this.metod,
      required this.widget,
      required this.width,
      required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(60),
      splashColor: EstiloApp.primarypink,
      onTap: metod,
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: height,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            gradient: EstiloApp.horizontalgradientblue,
            color: EstiloApp.primaryblue,
            boxShadow: kElevationToShadow[9],
            borderRadius: BorderRadius.circular(60)),
        child: Center(child: widget),
      ),
    );
  }
}
