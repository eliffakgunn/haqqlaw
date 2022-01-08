import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_genel.dart';
import 'login.dart';

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
      home: RegisterAvukat(),
    );
  }
}

class RegisterAvukat extends StatefulWidget {
  @override
  _RegisterAvukatState createState() => _RegisterAvukatState();
}

class _RegisterAvukatState extends State<RegisterAvukat> {
  Future<bool> onBackPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
    return Future<bool>.value(true);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String name = "",
      surname = "",
      number = "",
      IBAN = "",
      category = 'Aile Hukuku',
      email = "",
      password = "",
      confirmPassword = "";

  var _currencies = [
    'Aile Hukuku',
    'Sigorta Hukuku',
    'Miras Hukuku',
    'İcra ve İflas Hukuku',
    'Ticaret Hukuku',
    'Bilişim Hukuku',
    'Şirketler Hukuku',
    'Fikri Mülkiyet Hukuku',
    'Gayrimenkul Hukuku',
    'Tüketici Hukuku',
    'Enerji ve Madencilik Hukuku',
    'Sağlık Hukuku',
    'Ceza Hukuku',
    'İdare Hukuku',
    'Vergi Hukuku',
    'Yabancılar ve Vatandaşlk Hukuku',
    'Göçmen Hukuku',
    'İş ve Sosyal Güvenlik Hukuku'
  ];
  var _currentItem = 'Aile Hukuku';

  /*Future<bool> onBackPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => QuizHomePage()));
  }*/

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
                          "Dijital Hukuk Platformu Avukat Kaydı",
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
                  padding: const EdgeInsets.only(left: 47, bottom: 30),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Yeni bir avukat hesabı oluşturun.",
                      style:
                          TextStyle(fontSize: 15, color: HexColor("#23435E")),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 40,
                  width: 320,
                  child: new TextField(
                    textAlign: TextAlign.left,
                    onChanged: (String text) {
                      name = text;
                    },
                    decoration: InputDecoration(
                        labelText: 'İsim',
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
                  height: 40,
                  width: 320,
                  child: new TextField(
                    textAlign: TextAlign.left,
                    onChanged: (String text) {
                      surname = text;
                    },
                    decoration: InputDecoration(
                        labelText: 'Soyisim',
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
                  height: 40,
                  width: 320,
                  child: new TextField(
                    textAlign: TextAlign.left,
                    onChanged: (String text) {
                      number = text;
                    },
                    decoration: InputDecoration(
                        labelText: 'TBB Sicil No*',
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
                  height: 40,
                  width: 320,
                  alignment: Alignment.center,
                  child: new TextField(
                    textAlign: TextAlign.left,
                    onChanged: (String text) {
                      IBAN = text;
                    },
                    decoration: InputDecoration(
                        labelText: 'IBAN**',
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
                  height: 40,
                  width: 320,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: HexColor("#23435E"), width: 3),
                  ),
                  child: DropdownButton<String>(
                    items: _currencies.map((String dropDownString) {
                      return DropdownMenuItem<String>(
                        value: dropDownString,
                        child: Text(
                          dropDownString,
                          textAlign: TextAlign.start,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        this._currentItem = newValue!;
                        this.category = newValue;
                      });
                    },
                    value: _currentItem,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 40,
                  width: 320,
                  child: new TextField(
                    textAlign: TextAlign.left,
                    onChanged: (String text) {
                      email = text;
                    },
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
                SizedBox(height: 15),
                Container(
                  height: 40,
                  width: 320,
                  child: new TextField(
                    textAlign: TextAlign.left,
                    onChanged: (String text) {
                      password = text;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Parola',
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
                  height: 40,
                  width: 320,
                  child: new TextField(
                    textAlign: TextAlign.left,
                    onChanged: (String text) {
                      confirmPassword = text;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Parolayı onaylayın',
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
                      createPerson();
                    },
                    child: Text(
                      'Kaydol',
                      style:
                          TextStyle(color: HexColor("#d1dbe2"), fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 30,
                  child: TextButton(
                    onPressed: () {
                      clearAllFields();
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Login()));
                    },
                    child: Text(
                      "Zaten bir hesabınız var mı? Giriş yapın.",
                      style: TextStyle(color: HexColor("#23435E")),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 20, bottom: 10, right: 20),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "*Sicil numarınız ekibimiz tarafından sorgulama yapabilmek için gereklidir, başka kişilerle paylaşılmayacaktır.",
                      style:
                          TextStyle(fontSize: 15, color: HexColor("#23435E")),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "**Iban bilginiz ödemeleri alabilmeniz için gereklidir, başka kişilerle paylaşılmayacaktır.",
                      style:
                          TextStyle(fontSize: 15, color: HexColor("#23435E")),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> createPerson() async {
    if (name.length == 0 ||
        surname.length == 0 ||
        number.length == 0 ||
        IBAN.length == 0 ||
        email.length == 0 ||
        password.length == 0 ||
        confirmPassword.length == 0) {
      Fluttertoast.showToast(
          msg: 'Lütfen tüm alanları doldurun.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else if (password != confirmPassword) {
      Fluttertoast.showToast(
          msg: 'Şifreler uyuşmuyor.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else {
      final snapShot = await _firestore
          .collection('Kullanıcılar')
          .doc('Avukatlar')
          .collection('Avukatlar')
          .where('email', isEqualTo: this.email)
          .get();

      final snapShot2 = await _firestore
          .collection('Kullanıcılar')
          .doc('Müvekkiller')
          .collection('Müvekkiller')
          .where('email', isEqualTo: this.email)
          .get();

      var b1 = snapShot.docs.isEmpty;
      var b2 = snapShot2.docs.isEmpty;

      if (!b1 || !b2) {
        Fluttertoast.showToast(
            msg: 'Bu e-posta adresi kullanılıyor.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      } else if (b1 && b2) {
        try {
          var user = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);

          addPerson(user);

          Fluttertoast.showToast(
              msg: 'Kaydolma işlemi başarılı.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);

          clearAllFields();
          Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
        } catch (e) {
          print("hata = " + e.toString());

          Fluttertoast.showToast(
              msg: 'Hatalı bilgi girdiniz.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
        }
      }
    }
  }

  void clearAllFields() {
    name = "";
    surname = "";
    number = "";
    IBAN = "";
    category = 'Aile Hukuku';
    email = "";
    password = "";
    confirmPassword = "";
  }

  Future<void> addPerson(UserCredential user) async {
    await _firestore
        .collection("Kullanıcılar")
        .doc('Avukatlar')
        .collection('Avukatlar')
        .doc(user.user!.uid)
        .set({
      'adi': name,
      'soyadi': surname,
      'sicil_no': number,
      'IBAN': IBAN,
      'kategori': category,
      'email': email
    });

    await _firestore
        .collection("Kategoriler")
        .doc(category)
        .collection(category)
        .doc(user.user!.uid)
        .set({'avukat_adi': name + ' ' + surname});
  }
}
