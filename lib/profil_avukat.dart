import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haqqlaw/home_avukat.dart';
import 'package:hexcolor/hexcolor.dart';

import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilAvukat(),
    );
  }
}

class ProfilAvukat extends StatefulWidget {
  @override
  _ProfilAvukatState createState() => _ProfilAvukatState();
}

class _ProfilAvukatState extends State<ProfilAvukat> {
  late String email, password;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String hintName = '';
  String hintSurname = '';
  String hintMail = '';

  String name = '';
  String surname = '';
  String mail = '';

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  Future<bool> onBackPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => HomePageAvukat()));
    return Future<bool>.value(true);
  }

  @override
  void initState() {
    initFields();
    super.initState();
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
                  padding:
                      const EdgeInsets.only(top: 40, right: 10, bottom: 50),
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
                                    builder: (_) => HomePageAvukat()));
                          },
                        ),
                        SizedBox(
                          width: 90,
                        ),
                        Text(
                          "Profili Düzenle",
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
                Container(
                  alignment: Alignment.center,
                  height: 120,
                  width: 150,
                  child: Image.asset("images/resume.jpeg"),
                ),
                SizedBox(height: 30),
                Container(
                  height: 45,
                  width: 320,
                  child: new TextField(
                    textAlign: TextAlign.left,
                    onChanged: (String text) {
                      this.name = text;
                    },
                    controller: controller,
                    decoration: InputDecoration(
                        labelText: this.hintName,
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
                SizedBox(height: 15),
                Container(
                  height: 45,
                  width: 320,
                  child: new TextField(
                    textAlign: TextAlign.left,
                    onChanged: (String text) {
                      this.surname = text;
                    },
                    controller: controller2,
                    decoration: InputDecoration(
                        labelText: this.hintSurname,
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
                SizedBox(height: 15),
                Container(
                  height: 45,
                  width: 320,
                  alignment: Alignment.center,
                  child: new TextField(
                    textAlign: TextAlign.left,
                    onChanged: (String text) {
                      this.mail = text;
                    },
                    controller: controller3,
                    decoration: InputDecoration(
                        labelText: this.hintMail,
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
                SizedBox(height: 20),
                Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: HexColor("#23435E"),
                      borderRadius: BorderRadius.circular(15)),
                  child: FlatButton(
                    onPressed: () async {
                      updateProfile();
                    },
                    child: Text(
                      'Kaydet',
                      style:
                          TextStyle(color: HexColor("#d1dbe2"), fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 30,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      resetPassword(context);
                    },
                    child: Text(
                      "Parolayı sıfırla",
                      style: TextStyle(color: HexColor("#23435E")),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    alignment: Alignment.center,
                    width: 105,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.logout,
                          color: HexColor("#23435E"),
                        ),
                        TextButton(
                          onPressed: () {
                            logout();
                          },
                          child: Text(
                            "Çıkış yap",
                            style: TextStyle(
                                color: HexColor("#23435E"), fontSize: 15),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  void initFields() {
    print('initFields');
    _firestore
        .collection('Kullanıcılar')
        .doc('Avukatlar')
        .collection('Avukatlar')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          this.hintName = documentSnapshot.data()!['adi'];
          this.hintSurname = documentSnapshot.data()!['soyadi'];
          this.hintMail = documentSnapshot.data()!['email'];
        });

        print('hintName = ' + this.hintName);
        print('hintSurname = ' + this.hintSurname);
        print('hintMail = ' + this.hintMail);
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void updateProfile() {
    if (this.name.length == 0 &&
        this.surname.length == 0 &&
        this.mail.length == 0) {
      Fluttertoast.showToast(
          msg: 'Lütfen en az bir alanı doldurun.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else {
      var docRef = _firestore
          .collection('Kullanıcılar')
          .doc('Avukatlar')
          .collection('Avukatlar')
          .doc(_auth.currentUser!.uid);

      if (this.name.length != 0) {
        docRef.update({'adi': this.name});
        setState(() {
          this.hintName = this.name;
        });
      }

      if (this.surname.length != 0) {
        docRef.update({'soyadi': this.surname});
        setState(() {
          this.hintSurname = this.surname;
        });
      }

      if (this.mail.length != 0) {
        docRef.update({'email': this.mail});
        setState(() {
          this.hintMail = this.mail;
        });
      }

      Fluttertoast.showToast(
          msg: 'Profil başarıyla güncellendi.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);

      controller.clear();
      controller2.clear();
      controller3.clear();
    }
  }

  Future<void> resetPassword(BuildContext context) {
    String _email = "";

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                "Şifre Yenileme",
                textAlign: TextAlign.center,
                style: TextStyle(color: HexColor("#23435E"), fontSize: 18),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              content: Container(
                height: 150,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Email:",
                          style: TextStyle(
                              fontSize: 15, color: HexColor("#23435E")),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(width: 20.0),
                        Container(
                          height: 50,
                          width: 220,
                          child: TextField(
                            onChanged: (String text) {
                              setState(() {
                                _email = text;
                              });
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Email adresinizi giriniz'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            bool flag = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(_email);
                            if (flag) {
                              _auth.sendPasswordResetEmail(email: _email);
                              Fluttertoast.showToast(
                                  msg: 'Mail gönderildi.',
                                  toastLength: Toast.LENGTH_SHORT,
                                  webPosition: "center",
                                  webBgColor: "ff90a4ae");
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      'Eksik ya da hatalı mail adresi girdiniz',
                                  toastLength: Toast.LENGTH_SHORT,
                                  webPosition: "center",
                                  webBgColor: "ff90a4ae");
                            }
                          },
                          child: Text(
                            "Gönder",
                            style: TextStyle(
                                color: HexColor("#23435E"),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Vazgeç",
                            style: TextStyle(
                                color: HexColor("#23435E"),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ));
        });
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
  }
}
