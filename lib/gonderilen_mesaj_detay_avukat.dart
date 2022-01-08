import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haqqlaw/gonderilenler_avukat.dart';
import 'package:hexcolor/hexcolor.dart';

//import 'package:path_provider/path_provider.dart';
//import 'package:path

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GonderilenMesajDetayAvukat(),
    );
  }
}

class GonderilenMesajDetayAvukat extends StatefulWidget {
  @override
  _GonderilenMesajDetayAvukatState createState() =>
      _GonderilenMesajDetayAvukatState();
}

class _GonderilenMesajDetayAvukatState
    extends State<GonderilenMesajDetayAvukat> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> onBackPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => GonderilenlerAvukat()));
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> datas =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    String? avukat = datas['avukat'];
    String? dosyaAdi = datas['dosyaAdi'];
    String? indirilecekDosya = datas['indirilecekDosya'];
    String? icerik = datas['icerik'];
    String? konu = datas['konu'];
    String? docId = datas['docId'];
    String? tarih = datas['tarih'];

    return WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
          backgroundColor: HexColor("#d1dbe2"),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                            color: HexColor("#23435E"),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => GonderilenlerAvukat()));
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: HexColor("#23435E"),
                          ),
                          onPressed: () {
                            _showChoiseDialog(context, docId!);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        width: 400,
                        height: 50,
                        alignment: Alignment.topLeft,
                        child: Text(
                          konu!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: HexColor("#23435E"),
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        width: 400,
                        height: 15,
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Container(
                              width: 45,
                              height: 15,
                              child: Text(
                                'Tarih: ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: HexColor("#23435E"),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 250,
                              height: 15,
                              child: Text(
                                tarih!,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: HexColor("#23435E"),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        width: 400,
                        height: 15,
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 15,
                              child: Text(
                                'Alıcı: ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: HexColor("#23435E"),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 300,
                              height: 15,
                              child: Text(
                                avukat!,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: HexColor("#23435E"),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        width: 400,
                        height: 250,
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            icerik!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: HexColor("#23435E"),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                          width: 400,
                          height: 30,
                          alignment: Alignment.topLeft,
                          child: dosyaAdi!.length == 0
                              ? TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: HexColor("#23435E"),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ))
                              : TextButton(
                                  onPressed: () {
                                    downloadFile(indirilecekDosya!);
                                  },
                                  child: Text(
                                    dosyaAdi,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: HexColor("#23435E"),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 110,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: HexColor("#23435E"),
                              borderRadius: BorderRadius.circular(5)),
                          child: FlatButton(
                            onPressed: () => {},
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.reply,
                                    color: HexColor("#d1dbe2"), size: 20),
                                SizedBox(width: 5),
                                Text(
                                  'Yanıtla',
                                  style: TextStyle(
                                      color: HexColor("#d1dbe2"), fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Container(
                          height: 30,
                          width: 110,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: HexColor("#23435E"),
                              borderRadius: BorderRadius.circular(5)),
                          child: FlatButton(
                            onPressed: () => {},
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.forward,
                                    color: HexColor("#d1dbe2"), size: 20),
                                SizedBox(width: 5),
                                Text(
                                  'Yönlendir',
                                  style: TextStyle(
                                      color: HexColor("#d1dbe2"), fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void downloadFile(String dosyaAdi) async {
    /*Directory appDocDir = Directory.current;
    File downloadToFile = File('${appDocDir.path}/${dosyaAdi}_a');

    await _storage.ref(dosyaAdi).writeToFile(downloadToFile);*/

    /*Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/$dosyaAdi');

      await _storage
          .ref(dosyaAdi)
          .writeToFile(downloadToFile);*/
  }

  Future<void> _showChoiseDialog(BuildContext context, String docId) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Mesajı silmek istediğinizden emin misiniz?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: HexColor("#23435E"), fontSize: 15)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              content: Container(
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          deleteMessage(docId);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => GonderilenlerAvukat()));
                        },
                        child: Icon(
                          Icons.check,
                          color: HexColor("#23435E"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: HexColor("#23435E"),
                        ),
                      ),
                    ],
                  )));
        });
  }

  void deleteMessage(String id) {
    _firestore
        .collection("Mesajlar")
        .doc('Avukatlar')
        .collection('Gonderilenler')
        .doc(id)
        .delete();

    Fluttertoast.showToast(
        msg: 'Mesaj başarıyla silindi.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }
}
