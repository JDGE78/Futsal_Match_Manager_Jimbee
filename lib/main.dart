import 'package:flutter/material.dart';
import 'package:futsal_match_manager/players.dart';
import 'package:futsal_match_manager/select_screen.dart';
import 'package:flutter/services.dart'; // Importa el paquete SystemChrome(pantalla horizontal)

void main() {
  // Forzar la orientación en modo horizontal
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// *
//**VARIABLES GLOBALES */
  static String teamName = "Jimbee Cartagena";
  static int localGoal = 0;
  static int guestGoal = 0;
  static int localFouls = 0;
  static int guestFouls = 0;
  static bool localTimeOut = false;
  static bool guestTimeOut = false;
  static int localYellowsCards = 0;
  static int guestYellowsCards = 0;
  static int localRedCards = 0;
  static int guestRedCards = 0;
  static int matchMinutes = 20;
  static String matchHour = "";
  static int matchPeriod =
      1; //? SOLO CON VALORES 1 O 2, DEPENDIENDO DE LA PARTE DEL PARTIDO
  static String? matchPlace;
  static String matchTime = "12:00";
  static String rival = "";
  static bool isLocal = true;
  static bool endMatch = false;
  //* PARA INFORME DE EVENTOS
  static String textMinorityReport = "";
  static List MinorityReportList = [];
  static String timeReport = "";
  static int period = 1; //añadido V1
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futsal Match Manager',
      theme: ThemeData(
          primarySwatch: Colors.red, scaffoldBackgroundColor: Colors.black),
      //textTheme: Typography.whiteHelsinki), PARA LA FUENTE DE LA APP
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(
        title: 'Futsal Match Manager',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SelectScreen()));
          },
          child: const Icon(
            Icons.sports_soccer,
            size: 40,
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: const BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.black45,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //height: MediaQuery.of(context).size.width * 0.045,
              children: <Widget>[ //QUITADO PARA VERSION 2
                /*IconButton(
                    icon: const Icon(
                      Icons.supervised_user_circle,
                      color: Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Player()));
                    }),
                const IconButton(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                  onPressed: null,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.analytics_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {},
                ),*/
                Padding(
                  padding: EdgeInsets.only(right: 90),
                )
              ],
            )),
        body: Container(
          //PARTE SUPERIOR
          //decoracion
          decoration: const BoxDecoration(
            //borderRadius: BorderRadiusDirectional.circular(10.0),
            image: DecorationImage(
                image: AssetImage('assets/images/fondo.jpg'),
                alignment: Alignment.center,
                opacity: 0.1,
                fit: BoxFit.cover),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(178, 166, 14, 14),
                Color.fromARGB(255, 166, 14, 14),
                Colors.white
              ],
            ),
          ),
          child: Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              children: <Widget>[
                AppBar(
                  shadowColor: Colors.red,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(50)),
                  ),
                  toolbarHeight: MediaQuery.of(context).size.height * 0.04,
                  backgroundColor: Colors.black26,
                  centerTitle: true,
                  title: const Text(
                    "Futsal Match Manager",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/logoteam.png',
                          height: 70,
                          width: 70,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Jimbee Cartagena',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 20.0,
                                        color: Colors.black,
                                        offset: Offset(5.0, 5.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),

                //CENTRO PARA LOS WIDGETS DE STADISTICS
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.5,
                    alignment: Alignment.center,
                    child: const Expanded(
                      child: Row(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //DayCalendar(),
                            ],
                          ),
                        ]),
                      ]),
                    ),
                  ),
                ),

                //PARTE BAJA
              ],
            ),
          ),
        ),
      ),
    );
  }


}
