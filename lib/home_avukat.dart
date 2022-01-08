import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haqqlaw/home_genel.dart';
import 'package:haqqlaw/mesajlar_avukat.dart';
import 'package:haqqlaw/profil_avukat.dart';
import 'package:hexcolor/hexcolor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageAvukat(),
    );
  }
}

class HomePageAvukat extends StatefulWidget {
  @override
  _HomePageAvukatState createState() => _HomePageAvukatState();
}

class _HomePageAvukatState extends State<HomePageAvukat> {
  Future<bool> onBackPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
          backgroundColor: HexColor("#d1dbe2"),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 50),
                Container(
                  alignment: Alignment.center,
                  height: 120,
                  width: 150,
                  child: Image.asset("images/compliant.jpeg"),
                ),
                SizedBox(height: 20),
                Container(
                  child: Text(
                    "Haqq Hukuk Ofisi",
                    style: TextStyle(
                        fontSize: 25,
                        color: HexColor("#23435E"),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  height: 60,
                  width: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: HexColor("#23435E"),
                      borderRadius: BorderRadius.circular(15)),
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => MesajlarAvukat()))
                    },
                    padding: EdgeInsets.all(10.0),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.question_answer_rounded,
                              color: HexColor("#d1dbe2"),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Mesajlar',
                              style: TextStyle(
                                  color: HexColor("#d1dbe2"), fontSize: 18),
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  width: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: HexColor("#23435E"),
                      borderRadius: BorderRadius.circular(15)),
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ProfilAvukat()))
                    },
                    padding: EdgeInsets.all(10.0),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: HexColor("#d1dbe2"),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Profil',
                              style: TextStyle(
                                  color: HexColor("#d1dbe2"), fontSize: 18),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
