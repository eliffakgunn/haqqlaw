import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haqqlaw/gonderilenler_muvekkil.dart';
import 'package:haqqlaw/home_muvekkil.dart';
import 'package:haqqlaw/yeni_mesaj_muvekkil.dart';
import 'package:hexcolor/hexcolor.dart';

import 'gelen_kutusu_muvekkil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MesajlarMuvekkil(),
    );
  }
}

class MesajlarMuvekkil extends StatefulWidget {
  @override
  _MesajlarMuvekkilState createState() => _MesajlarMuvekkilState();
}

class _MesajlarMuvekkilState extends State<MesajlarMuvekkil> {
  Future<bool> onBackPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => HomePageMuvekkil()));
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

                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: HexColor("#23435E"),
                      ),
                      onPressed: () {
                        //clearAllFields();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => HomePageMuvekkil()));
                      },
                    ),
                    SizedBox(
                      width: 110,
                    ),
                    Text(
                      "Mesajlarım",
                      style: TextStyle(
                          fontSize: 25,
                          color: HexColor("#23435E"),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                SizedBox(height: 40),

                Container(
                  height: 150,
                  width: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: HexColor("#23435E"),
                      borderRadius: BorderRadius.circular(15)),
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => YeniMesajMuvekkil()))
                    },
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        SizedBox(height: 15),
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          child: Image.asset("images/question.jpeg"),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Yeni Mesaj',
                          style: TextStyle(
                              color: HexColor("#d1dbe2"), fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ), //),

                SizedBox(height: 20),

                Container(
                  height: 150,
                  width: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: HexColor("#23435E"),
                      borderRadius: BorderRadius.circular(15)),
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => GelenKutusuMuvekkil()))
                    },
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        SizedBox(height: 15),
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          child: Image.asset("images/q.jpeg"),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Gelen Kutusu',
                          style: TextStyle(
                              color: HexColor("#d1dbe2"), fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ), //

                SizedBox(height: 20),

                Container(
                  height: 150,
                  width: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: HexColor("#23435E"),
                      borderRadius: BorderRadius.circular(15)),
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => GonderilenlerMuvekkil()))
                    },
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        SizedBox(height: 15),
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          child: Image.asset("images/qa.jpeg"),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Gönderilenler',
                          style: TextStyle(
                              color: HexColor("#d1dbe2"), fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
