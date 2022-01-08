import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'home_muvekkil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AvukatIslemleriMuvekkil(),
    );
  }
}

class AvukatIslemleriMuvekkil extends StatefulWidget {
  @override
  _AvukatIslemleriMuvekkilState createState() =>
      _AvukatIslemleriMuvekkilState();
}

class _AvukatIslemleriMuvekkilState extends State<AvukatIslemleriMuvekkil> {
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
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 80, left: 20, bottom: 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "AvukatIslemleriMuvekkil",
                      style:
                          TextStyle(fontSize: 20, color: HexColor("#23435E")),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
