import 'package:flutter/material.dart';
import 'package:sfs_emprendedor/src/global/routes.dart';
import 'package:sfs_emprendedor/src/pages/auth/login.dart';
import 'package:sfs_emprendedor/src/styles/custom_styles.dart';
import 'package:sfs_emprendedor/src/widgets/buttonaccion.dart';
import 'package:sfs_emprendedor/src/widgets/widgettext.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  bool isHovering = false;
  var size;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Stack(children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'asset/img/handshaking.jpg',
                ),
              ),
            ),
            height: height / 2,
          ),
          Container(
            height: height / 2,
            decoration: const BoxDecoration(
                color: Colors.white, gradient: EstiloApp.verticalgradientwhite),
          )
        ]),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              H2('EL FINANCIAMIENTO', EstiloApp.primaryblue, TextAlign.center,
                  'Montserrat', FontWeight.w800, FontStyle.normal),
              Container(
                decoration: BoxDecoration(
                    gradient: EstiloApp.horizontalgradientpurplepink,
                    borderRadius: BorderRadius.circular(60)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: H2(
                    'QUE BUSCAS CON LOS',
                    EstiloApp.colorwhite,
                    TextAlign.center,
                    'Montserrat',
                    FontWeight.w400,
                    FontStyle.normal),
              ),
              H2('MEJORES RESULTADOS', EstiloApp.primaryblue, TextAlign.center,
                  'Montserrat', FontWeight.w800, FontStyle.normal),
              SizedBox(height: height * 0.1),
              button(() {
                Navigator.pushNamed(context, PageRoutes().login);
              },
                  H5('INICIAR SESION', EstiloApp.colorwhite, TextAlign.center,
                      'Montserrat', FontWeight.w500, FontStyle.normal),
                  MediaQuery.of(context).size.width * 0.5,
                  60,
                  EstiloApp.horizontalgradientpurplepink),
              SizedBox(height: height * 0.01),
              button(() {
                Navigator.pushNamed(context, '/register');
              },
                  H5('REGISTRARSE', EstiloApp.colorwhite, TextAlign.center,
                      'Montserrat', FontWeight.w500, FontStyle.normal),
                  MediaQuery.of(context).size.width * 0.5,
                  60,
                  EstiloApp.horizontalgradientblue),
              SizedBox(height: height * 0.01),
              InkWell(
                onTap: () => Navigator.pushNamed(context, '/login'),
                child: H3(
                    '¡CONOCE MAS AHORA!',
                    EstiloApp.primaryblue,
                    TextAlign.center,
                    'Montserrat',
                    FontWeight.w800,
                    FontStyle.normal),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'asset/icons/degradado/iconlogo.png',
                  width: 70,
                ),
                const Text('SFS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: EstiloApp.primaryblue,
                        fontSize: 52,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        )
      ],
    );
  }
}
