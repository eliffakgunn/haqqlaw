import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haqqlaw/mesajlar_muvekkil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/widgets.dart';

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
      home: YeniMesajMuvekkil(),
    );
  }
}

class YeniMesajMuvekkil extends StatefulWidget {
  @override
  _YeniMesajMuvekkilState createState() => _YeniMesajMuvekkilState();
}

class _YeniMesajMuvekkilState extends State<YeniMesajMuvekkil> {
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

  String muvekkil_adi = '';

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  String subject = '';
  String text = '';

  File? file;
  String fileName = '';

  String avukatID = '';

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

    setState(() {
      fileName = name;
    });
    return name;
  }

  Future<bool> onBackPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => MesajlarMuvekkil()));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MesajlarMuvekkil()));
                      },
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Yeni Mesaj Oluştur",
                      style: TextStyle(
                          fontSize: 25,
                          color: HexColor("#23435E"),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
                                  this.text = text;
                                });
                              },
                              controller: controller,
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
                    onPressed: () async {
                      sendMessage();
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

  void clearAllFields() {
    setState(() {
      file = null;
      subject = '';
      text = '';
      this.fileName = '';
    });
    controller.clear();
    controller2.clear();
  }

  void sendMessage() {
    if (subject.length == 0 || text.length == 0) {
      Fluttertoast.showToast(
          msg: 'Lütfen tüm alanları doldurun.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else {
      String fileName2 =
          fileName.length != 0 ? '${DateTime.now()}_$fileName' : '';

      DocumentReference docID1 = _firestore
          .collection("Mesajlar")
          .doc('Muvekkiller')
          .collection('Gonderilenler')
          .doc();

      DocumentReference docID2 = _firestore
          .collection("Mesajlar")
          .doc('Avukatlar')
          .collection('Gelen Kutusu')
          .doc();

      var collection = _firestore
          .collection('Kullanıcılar')
          .doc('Müvekkiller')
          .collection('Müvekkiller');
      var docSnapshot =
          collection.doc(FirebaseAuth.instance.currentUser!.uid).get();

      docSnapshot.then((value) => setState(() {
            muvekkil_adi = value.data()!['adi'];

            docID1.set({
              'kategori': currCategory,
              'avukat': currLawyer,
              'konu': this.subject,
              'icerik': this.text,
              'dosyaAdi': fileName,
              'indirilecekDosya': fileName2,
              'tarih': DateTime.now(),
              'muvekkilID': FirebaseAuth.instance.currentUser!.uid,
              'muvekkilAdi': muvekkil_adi
            });

            docID2.set({
              'kategori': currCategory,
              'avukat': currLawyer,
              'konu': this.subject,
              'icerik': this.text,
              'dosyaAdi': fileName,
              'indirilecekDosya': fileName2,
              'tarih': DateTime.now(),
              'muvekkilID': FirebaseAuth.instance.currentUser!.uid,
              'muvekkilAdi': muvekkil_adi,
              'isOnline': '0'
            });

            var snapshot = _firestore
                .collection('Kullanıcılar')
                .doc('Avukatlar')
                .collection('Avukatlar')
                .where('adi', isEqualTo: currLawyer)
                .get();

            snapshot.then((value2) => setState(() {
                  print("ğğ");
                  docID1.update({
                    'avukatID': value2.docs.first.id,
                  }).then((value1) => print("doc1 ekkendi"));

                  docID2.update({
                    'avukatID': value2.docs.first.id,
                  }).then((value1) => print("doc2 ekkendi"));
                }));

            if (fileName.length != 0)
              _storage.ref().child(fileName2).putFile(file!);

            Fluttertoast.showToast(
                msg: 'Mesajınız başarıyla gönderildi.',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM);

            clearAllFields();
          }));
    }
  }

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
