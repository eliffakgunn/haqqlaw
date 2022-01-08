import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haqqlaw/home_avukat.dart';
import 'package:haqqlaw/home_muvekkil.dart';
import 'package:haqqlaw/register_avukat.dart';
import 'package:haqqlaw/register_muvekkil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_genel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String email = '', password = '';
  bool visible = true;

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

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
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50, right: 10),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                            color: HexColor("#23435E"),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MyHomePage()));
                          },
                        ),
                        Text(
                          "Dijital Hukuk Platformu Kullanıcı Girişi",
                          style: TextStyle(
                              fontSize: 20,
                              color: HexColor("#23435E"),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 47, bottom: 45),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Oturum açmak için kayıtlı bir hesap kullanın.",
                      style:
                          TextStyle(fontSize: 15, color: HexColor("#23435E")),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 40,
                  width: 290,
                  alignment: Alignment.center,
                  child: new TextField(
                    textAlign: TextAlign.left,
                    onChanged: (String text) {
                      email = text;
                    },
                    controller: controller,
                    decoration: InputDecoration(
                        labelText: 'E-posta',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: HexColor("#23435E")),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: HexColor("#23435E")),
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 45,
                    ),
                    Container(
                      height: 40,
                      width: 290,
                      child: new TextField(
                        textAlign: TextAlign.left,
                        onChanged: (String text) {
                          password = text;
                        },
                        controller: controller2,
                        obscureText: visible,
                        decoration: InputDecoration(
                            labelText: 'Parola',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: HexColor("#23435E")),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: HexColor("#23435E")),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        visible ? Icons.visibility : Icons.visibility_off,
                        color: HexColor("#23435E"),
                      ),
                      onPressed: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: HexColor("#23435E"),
                      borderRadius: BorderRadius.circular(15)),
                  child: FlatButton(
                    onPressed: () async {
                      signIn();
                    },
                    child: Text(
                      'Giriş Yap',
                      style:
                          TextStyle(color: HexColor("#d1dbe2"), fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 30,
                  child: TextButton(
                    onPressed: () {
                      clearAllFields();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RegisterMuvekkil()));
                    },
                    child: Text(
                      "Yeni bir müvekkil hesabı oluşturun.",
                      style: TextStyle(color: HexColor("#23435E")),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  child: TextButton(
                    onPressed: () {
                      clearAllFields();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => RegisterAvukat()));
                    },
                    child: Text(
                      "Yeni bir avukat hesabı oluşturun.",
                      style: TextStyle(color: HexColor("#23435E")),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Parolanızı mı unuttunuz?",
                      style: TextStyle(color: HexColor("#23435E")),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void clearAllFields() {
    email = '';
    password = '';
    controller.clear();
    controller2.clear();
  }

  Future<void> signIn() async {
    if (email.length == 0 || password.length == 0) {
      Fluttertoast.showToast(
          msg: 'Lütfen tüm alanları doldurun.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        final snapShot = await _firestore
            .collection('Kullanıcılar')
            .doc('Avukatlar')
            .collection('Avukatlar')
            .where('email', isEqualTo: this.email)
            .get();

        print(snapShot.docs.isNotEmpty);

        if (snapShot.docs.isNotEmpty) {
          clearAllFields();
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomePageAvukat()));
        } else {
          clearAllFields();
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomePageMuvekkil()));
        }
      } catch (e) {
        print("error");
        print(e.toString());

        Fluttertoast.showToast(
            msg: 'Hatalı bilgi girdiniz.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }
    }
  }
}
