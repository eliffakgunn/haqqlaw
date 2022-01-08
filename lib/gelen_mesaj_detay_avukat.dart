import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haqqlaw/gelen_kutusu_avukat.dart';
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
      home: GelenMesajDetayAvukat(),
    );
  }
}

class GelenMesajDetayAvukat extends StatefulWidget {
  @override
  _GelenMesajDetayAvukatState createState() => _GelenMesajDetayAvukatState();
}

class _GelenMesajDetayAvukatState extends State<GelenMesajDetayAvukat> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  TextEditingController _editTextController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool isVisible = false;
  bool isVisible2 = true;
  bool isVisible3 = false;
  String yanit = '';

  File? file;
  String fileName = '';

  Future<bool> onBackPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => GelenKutusuAvukat()));
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> datas =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final fileName = file != null ? getFileName() : 'Dosya seçilmedi.';

    String? dosyaAdi = datas['dosyaAdi'];
    String? indirilecekDosya = datas['indirilecekDosya'];
    String? icerik = datas['icerik'];
    String? konu = datas['konu'];
    String? kategori = datas['kategori'];
    String? docId = datas['docId'];
    String? muvekkilAdi = datas['muvekkilAdi'];
    String? avukatAdi = datas['avukatAdi'];
    String? muvekkilID = datas['muvekkilID'];
    String? tarih = datas['tarih'];
    String? isOnline = datas['isOnline'];

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
                                    builder: (_) => GelenKutusuAvukat()));
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
                              width: 75,
                              height: 15,
                              child: Text(
                                'Gönderen: ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: HexColor("#23435E"),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 280,
                              height: 15,
                              child: Text(
                                muvekkilAdi!,
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
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        width: 400,
                        height: 150,
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
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 25),
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
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        width: 500,
                        //height: 150,
                        alignment: Alignment.topLeft,
                        child: Visibility(
                            visible: isVisible,
                            child: Column(
                              children: [
                                /*child:*/ Scrollbar(
                                  controller: _scrollController,
                                  child: TextField(
                                    controller: _editTextController,
                                    autofocus: true,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 4,
                                    onChanged: (String text) => {
                                      setState(() {
                                        yanit = text;
                                      })
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Yanıt',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: HexColor("#23435E")),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: HexColor("#23435E")),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        fileName,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: HexColor("#23435E")),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(width: 25),
                                    FlatButton(
                                      onPressed: selectFile,
                                      padding: EdgeInsets.all(1.0),
                                      child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
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
                                                    color: HexColor("#23435E"),
                                                    fontSize: 13),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: isVisible2,
                      child: Row(
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
                              onPressed: () => {
                                setState(() {
                                  isVisible = true;
                                  isVisible2 = false;
                                  isVisible3 = true;
                                })
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.reply,
                                      color: HexColor("#d1dbe2"), size: 20),
                                  SizedBox(width: 5),
                                  Text(
                                    'Yanıtla',
                                    style: TextStyle(
                                        color: HexColor("#d1dbe2"),
                                        fontSize: 12),
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
                                        color: HexColor("#d1dbe2"),
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isVisible3,
                      child: Container(
                        height: 35,
                        width: 90,
                        decoration: BoxDecoration(
                            color: HexColor("#23435E"),
                            borderRadius: BorderRadius.circular(5)),
                        child: FlatButton(
                          onPressed: () async {
                            sendReply(kategori!, konu, icerik, muvekkilAdi,
                                muvekkilID!, avukatAdi!, tarih);
                          },
                          child: Text(
                            'Gönder',
                            style: TextStyle(
                                color: HexColor("#d1dbe2"), fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
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

  void sendReply(String kategori, String konu, String icerik,
      String muvekkilAdi, String muvekkilID, String avukatAdi, String tarih) {
    String yeniICerik = this.yanit +
        '\n\n------------------------------\n\n' +
        'Tarih: $tarih\n' +
        'Gönderen: $muvekkilAdi\n\n' +
        icerik;
    String fileName2 =
        fileName.length != 0 ? '${DateTime.now()}_$fileName' : '';

    _firestore
        .collection("Mesajlar")
        .doc('Muvekkiller')
        .collection('Gelen Kutusu')
        .doc()
        .set({
      'avukat': avukatAdi,
      'avukatID': FirebaseAuth.instance.currentUser!.uid,
      'kategori': kategori,
      'konu': konu,
      'icerik': yeniICerik,
      'dosyaAdi': fileName,
      'indirilecekDosya': fileName2,
      'tarih': DateTime.now(),
      'muvekkilID': muvekkilID,
      'muvekkilAdi': muvekkilAdi
    });

    _firestore
        .collection("Mesajlar")
        .doc('Avukatlar')
        .collection('Gonderilenler')
        .doc()
        .set({
      'avukat': avukatAdi,
      'avukatID': FirebaseAuth.instance.currentUser!.uid,
      'kategori': kategori,
      'konu': konu,
      'icerik': yeniICerik,
      'dosyaAdi': fileName,
      'indirilecekDosya': fileName2,
      'tarih': DateTime.now(),
      'muvekkilID': muvekkilID,
      'muvekkilAdi': muvekkilAdi
    });

    if (fileName.length != 0) _storage.ref().child(fileName2).putFile(file!);

    Fluttertoast.showToast(
        msg: 'Yanıtınız başarıyla gönderildi.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);

    _editTextController.clear();

    setState(() {
      isVisible = false;
      isVisible2 = true;
      isVisible3 = false;
    });
  }

  void downloadFile(String dosyaAdi) async {}

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
                                  builder: (_) => GelenKutusuAvukat()));
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
        .collection('Gelen Kutusu')
        .doc(id)
        .delete();

    Fluttertoast.showToast(
        msg: 'Mesaj başarıyla silindi.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }
}
