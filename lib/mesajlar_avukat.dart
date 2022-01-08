import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haqqlaw/gelen_kutusu_avukat.dart';
import 'package:haqqlaw/gonderilenler_avukat.dart';
import 'package:haqqlaw/home_avukat.dart';
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
      home: MesajlarAvukat(),
    );
  }
}

class MesajlarAvukat extends StatefulWidget {
  @override
  _MesajlarAvukatState createState() => _MesajlarAvukatState();
}

class _MesajlarAvukatState extends State<MesajlarAvukat> {
  Future<bool> onBackPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => HomePageAvukat()));
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
                                builder: (_) => HomePageAvukat()));
                      },
                    ),
                    SizedBox(
                      width: 100,
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
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 80, bottom: 80),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
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
                                    builder: (_) => GelenKutusuAvukat()))
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

                      SizedBox(height: 50),

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
                                    builder: (_) => GonderilenlerAvukat()))
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
