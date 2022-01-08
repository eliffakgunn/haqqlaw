import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haqqlaw/home_muvekkil.dart';
import 'package:haqqlaw/randevu_olustur_muvekkil.dart';
import 'package:haqqlaw/randevular%C4%B1m_muvekkil.dart';
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
      home: RandevuIslemleriMuvekkil(),
    );
  }
}

class RandevuIslemleriMuvekkil extends StatefulWidget {
  @override
  _RandevuIslemleriMuvekkilState createState() =>
      _RandevuIslemleriMuvekkilState();
}

class _RandevuIslemleriMuvekkilState extends State<RandevuIslemleriMuvekkil> {
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
                      width: 60,
                    ),
                    Text(
                      "Randevu İşlemleri",
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
                                    builder: (_) => RandevularimMuvekkil()))
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
                                child: Image.asset("images/calendar.jpeg"),
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Randevularım',
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
                                    builder: (_) => RandevuOlusturMuvekkil()))
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
                                child: Image.asset("images/appointments.jpeg"),
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Randevu Oluştur',
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
