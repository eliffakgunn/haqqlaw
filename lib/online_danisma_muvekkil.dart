import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haqqlaw/home_genel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

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
      home: OnlineDanismaMuvekkil(),
    );
  }
}

class OnlineDanismaMuvekkil extends StatefulWidget {
  @override
  _OnlineDanismaMuvekkilState createState() => _OnlineDanismaMuvekkilState();
}

class _OnlineDanismaMuvekkilState extends State<OnlineDanismaMuvekkil> {
  List<String> category = [
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
    'Yabancılar ve Vatandaşlık Hukuku',
    'Göçmen Hukuku',
    'İş ve Sosyal Güvenlik Hukuku'
  ];
  String currCategory = 'Aile Hukuku';

  List<String> lawyer = [];
  String currLawyer = '';

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  String name = '';
  String email = '';
  String subject = '';
  String content = '';

  File? file;
  String fileName = '';

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    updateLawyers();
    super.initState();
  }

  String getFileName() {
    String name = '';
    int i = 0;
    for (i = file!.path.length - 1; i > 0; --i) {
      if (file!.path[i] == '/') {
        break;
      }
    }

    for (int j = i + 1; j < file!.path.length; ++j) {
      name += file!.path[j];
    }
    return name;
  }

  Future<bool> onBackPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? getFileName() : 'Dosya seçilmedi.';

    return WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
          backgroundColor: HexColor("#d1dbe2"),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 45),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: HexColor("#23435E"),
                      ),
                      onPressed: () {
                        clearAllFields();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MyHomePage()));
                      },
                    ),
                    SizedBox(
                      width: 75,
                    ),
                    Text(
                      "Online Danışma",
                      style: TextStyle(
                          fontSize: 25,
                          color: HexColor("#23435E"),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Text(
                  "Avukata Soru Sor",
                  style: TextStyle(fontSize: 20, color: HexColor("#23435E")),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Kategori:",
                          style: TextStyle(
                              fontSize: 18, color: HexColor("#23435E")),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 19),
                      Container(
                        height: 40,
                        width: 300,
                        alignment: Alignment.topLeft,
                        child: DropdownButton<String>(
                          items: category.map((String dropDownString) {
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
                              this.currCategory = newValue!;
                              updateLawyers();
                            });
                          },
                          value: currCategory,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Avukat:",
                          style: TextStyle(
                              fontSize: 18, color: HexColor("#23435E")),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 29),
                      Container(
                        height: 40,
                        width: 300,
                        alignment: Alignment.topLeft,
                        child: DropdownButton<String>(
                          items: lawyer.map((String dropDownString) {
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
                              this.currLawyer = newValue!;
                            });
                          },
                          value: currLawyer,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "İsim:",
                          style: TextStyle(
                              fontSize: 18, color: HexColor("#23435E")),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 50),
                      Container(
                        height: 40,
                        width: 280,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border:
                              Border.all(color: HexColor("#23435E"), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextField(
                              onChanged: (String text) {
                                setState(() {
                                  this.name = text;
                                });
                              },
                              controller: controller4,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: "İsim",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "E-posta:",
                          style: TextStyle(
                              fontSize: 18, color: HexColor("#23435E")),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 23),
                      Container(
                        height: 40,
                        width: 280,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border:
                              Border.all(color: HexColor("#23435E"), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextField(
                              onChanged: (String text) {
                                setState(() {
                                  this.email = text;
                                });
                              },
                              controller: controller,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: "E-posta",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Konu:",
                          style: TextStyle(
                              fontSize: 18, color: HexColor("#23435E")),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 42),
                      Container(
                        height: 40,
                        width: 280,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border:
                              Border.all(color: HexColor("#23435E"), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextField(
                              onChanged: (String text) {
                                setState(() {
                                  this.subject = text;
                                });
                              },
                              controller: controller2,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: "Konu",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "İçerik:",
                        style:
                            TextStyle(fontSize: 18, color: HexColor("#23435E")),
                      ),
                      SizedBox(width: 40),
                      Container(
                        height: 200,
                        width: 280,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border:
                              Border.all(color: HexColor("#23435E"), width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: TextField(
                              onChanged: (String text) {
                                setState(() {
                                  this.content = text;
                                });
                              },
                              controller: controller3,
                              maxLines: 8,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: "İçerik",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Dosya:",
                          style: TextStyle(
                              fontSize: 18, color: HexColor("#23435E")),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 25),

                      FlatButton(
                        onPressed: selectFile,
                        padding: EdgeInsets.all(1.0),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.attach_file,
                                  color: HexColor("#23435E"),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Yükle',
                                  style: TextStyle(
                                      color: HexColor("#23435E"), fontSize: 15),
                                ),
                              ],
                            )),
                      ),
                      //),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 115,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 270,
                        alignment: Alignment.topLeft,
                        child: Text(
                          fileName,
                          style: TextStyle(
                              fontSize: 12, color: HexColor("#23435E")),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: HexColor("#23435E"),
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      sendMessage();
                      /*sendMessage(
                          email: this.email,
                          subject: this.subject,
                          content: this.content);*/
                    },
                    child: Text(
                      'Gönder',
                      style:
                          TextStyle(color: HexColor("#d1dbe2"), fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }

  void sendMessage() {
    if (this.name.length == 0 ||
        this.email.length == 0 ||
        this.subject.length == 0 ||
        this.content.length == 0) {
      Fluttertoast.showToast(
          msg: 'Lütfen tüm alanları doldurun.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else {
      String fileName2 =
          fileName.length != 0 ? '${DateTime.now()}_$fileName' : '';

      DocumentReference docRef = _firestore
          .collection("Mesajlar")
          .doc('Avukatlar')
          .collection('Gelen Kutusu')
          .doc();

      docRef.set({
        'kategori': currCategory,
        'avukat': currLawyer,
        'konu': this.subject,
        'icerik': this.content,
        'dosyaAdi': fileName,
        'indirilecekDosya': fileName2,
        'tarih': DateTime.now(),
        'muvekkilID': '',
        'muvekkilAdi': this.name,
        'isOnline': '1'
      });

      var snapshot = _firestore
          .collection('Kullanıcılar')
          .doc('Avukatlar')
          .collection('Avukatlar')
          .where('adi', isEqualTo: currLawyer)
          .get();

      snapshot.then((value2) => setState(() {
            docRef.update({
              'avukatID': value2.docs.first.id,
            }).then((value1) => print("doc2 ekkendi"));
          }));

      if (fileName.length != 0) _storage.ref().child(fileName2).putFile(file!);

      Fluttertoast.showToast(
          msg: 'Mesajınız başarıyla gönderildi.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);

      clearAllFields();
    }
  }

  void clearAllFields() {
    controller.clear();
    controller2.clear();
    controller3.clear();
    controller4.clear();

    setState(() {
      this.file = null;
      this.name = '';
      this.email = '';
      this.subject = '';
      this.content = '';
      this.fileName = '';
    });
  }

  /*Future sendMessage(
      {required String email,
      required String subject,
      required String content}) async {
    if (this.email.length == 0 ||
        this.subject.length == 0 ||
        this.content.length == 0) {
      Fluttertoast.showToast(
          msg: 'Lütfen tüm alanları doldurun.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else {
      final serviceId = 'service_vxk9wep';
      final templateId = 'template_ogy8l4v';
      final userId = 'user_OiztcZa6x34VJP9Txoy0C';

      print('email = $email');
      print('subject = $subject');
      print('content = $content');

      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_email': email,
            'user_subject': subject,
            'user_message': content
          }
        }),
      );

      print('stat =  ${response.statusCode}');

      /*final Email email = Email(
        body: this.content,
        subject: this.subject,
        recipients: ['eliffakgunn@gmail.com'],
        isHTML: false,
      );

      String platformResponse;

      try {
        await FlutterEmailSender.send(email);
        platformResponse = 'success';
      } catch (error) {
        platformResponse = error.toString();
      }*/
    }
  }*/

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  void updateLawyers() {
    lawyer.clear();
    FirebaseFirestore.instance
        .collection('Kategoriler')
        .doc(currCategory)
        .collection(currCategory)
        .get()
        .then((QuerySnapshot querySnapshot) {
      int i = 0;
      querySnapshot.docs.forEach((doc) {
        setState(() {
          this.lawyer.add(doc["avukat_adi"]);
        });
        if (i == 0) {
          setState(() {
            this.currLawyer = doc["avukat_adi"];
          });
        }
      });
    });
  }
}
