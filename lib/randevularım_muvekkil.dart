import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haqqlaw/randevu_islemleri_muvekkil.dart';
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
      home: RandevularimMuvekkil(),
    );
  }
}

class RandevularimMuvekkil extends StatefulWidget {
  @override
  _RandevularimMuvekkilState createState() => _RandevularimMuvekkilState();
}

class _RandevularimMuvekkilState extends State<RandevularimMuvekkil> {
  Future<bool> onBackPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => RandevuIslemleriMuvekkil()));
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
                                builder: (_) => RandevuIslemleriMuvekkil()));
                      },
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Text(
                      "Randevularım",
                      style: TextStyle(
                          fontSize: 25,
                          color: HexColor("#23435E"),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
