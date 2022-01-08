import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haqqlaw/gelen_mesaj_detay_muvekkil.dart';
import 'package:haqqlaw/mesajlar_muvekkil.dart';
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
      home: GelenKutusuMuvekkil(),
    );
  }
}

class GelenKutusuMuvekkil extends StatefulWidget {
  @override
  _GelenKutusuMuvekkilState createState() => _GelenKutusuMuvekkilState();
}

class _GelenKutusuMuvekkilState extends State<GelenKutusuMuvekkil> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> onBackPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => MesajlarMuvekkil()));
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
                SizedBox(height: 45),
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
                                builder: (_) => MesajlarMuvekkil()));
                      },
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Text(
                      "Gelen Kutusu",
                      style: TextStyle(
                          fontSize: 25,
                          color: HexColor("#23435E"),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 5, bottom: 10, right: 5),
                    child: StreamBuilder(
                      stream: getMessages(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        return !snapshot.hasData
                            ? Container(
                                width: 250,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  "Mesaj bulunamadı.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: HexColor("#23435E")),
                                ),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot mypost =
                                      snapshot.data!.docs[index];

                                  Timestamp t = mypost['tarih'];

                                  String date = t.toDate().day.toString() +
                                      '/' +
                                      t.toDate().month.toString() +
                                      '/' +
                                      t.toDate().year.toString() +
                                      ' ' +
                                      t.toDate().hour.toString() +
                                      ':' +
                                      t.toDate().minute.toString();

                                  Map<String, String> datas = {
                                    'konu': mypost['konu'],
                                    'icerik': mypost['icerik'],
                                    'dosyaAdi': mypost['dosyaAdi'],
                                    'muvekkilAdi': mypost['muvekkilAdi'],
                                    'avukat': mypost['avukat'],
                                    'avukatID': mypost['avukatID'],
                                    'muvekkilID': mypost['muvekkilID'],
                                    'indirilecekDosya':
                                        mypost['indirilecekDosya'],
                                    'kategori': mypost['kategori'],
                                    'docId': mypost.id,
                                    'tarih': date
                                  };

                                  return InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            GelenMesajDetayMuvekkil(),
                                        settings: RouteSettings(
                                          arguments: datas,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        height: 90,
                                        decoration: BoxDecoration(
                                            color: Colors.white70,
                                            border: Border.all(
                                                color: HexColor("#23435E"),
                                                width: 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10,
                                                    right: 5,
                                                    left: 5,
                                                    bottom: 5),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: 250,
                                                      height: 15,
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 65,
                                                            height: 15,
                                                            child: Text(
                                                              'Gönderen: ',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  color: HexColor(
                                                                      "#23435E"),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 180,
                                                            height: 15,
                                                            child: Text(
                                                              mypost['avukat'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  color: HexColor(
                                                                      "#23435E"),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                          mypost['muvekkilAdi']
                                                                      .toString()
                                                                      .length >
                                                                  15
                                                              ? Text(
                                                                  '...',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      color: HexColor(
                                                                          "#23435E"),
                                                                      fontSize:
                                                                          13),
                                                                )
                                                              : Text(''),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Container(
                                                      width: 250,
                                                      height: 15,
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 40,
                                                            height: 15,
                                                            child: Text(
                                                              'Konu: ',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  color: HexColor(
                                                                      "#23435E"),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 180,
                                                            height: 15,
                                                            child: Text(
                                                              mypost['konu'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  color: HexColor(
                                                                      "#23435E"),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                          mypost['konu']
                                                                      .toString()
                                                                      .length >
                                                                  15
                                                              ? Text(
                                                                  '...',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      color: HexColor(
                                                                          "#23435E"),
                                                                      fontSize:
                                                                          13),
                                                                )
                                                              : Text(''),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Container(
                                                      width: 250,
                                                      height: 15,
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 40,
                                                            height: 15,
                                                            child: Text(
                                                              'İçerik: ',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  color: HexColor(
                                                                      "#23435E"),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 180,
                                                            height: 15,
                                                            child: Text(
                                                              mypost['icerik'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  color: HexColor(
                                                                      "#23435E"),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                          mypost['icerik']
                                                                      .toString()
                                                                      .length >
                                                                  15
                                                              ? Text(
                                                                  '...',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      color: HexColor(
                                                                          "#23435E"),
                                                                      fontSize:
                                                                          13),
                                                                )
                                                              : Text(''),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5,
                                                    right: 5,
                                                    bottom: 5),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      date,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              "#23435E"),
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    mypost['dosyaAdi']
                                                                .toString()
                                                                .length ==
                                                            0
                                                        ? Text('')
                                                        : Icon(
                                                            Icons.attach_file,
                                                            color: HexColor(
                                                                "#23435E"),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Stream<QuerySnapshot> getMessages() {
    var collection = _firestore
        .collection('Kullanıcılar')
        .doc('Avukatlar')
        .collection('Avukatlar');
    var docSnapshot =
        collection.doc(FirebaseAuth.instance.currentUser!.uid).get();

    /*docSnapshot.then((value) => setState(() {
          avukat_adi = value.data()!['adi'];
        }));*/

    Stream<QuerySnapshot> ref;
    ref = _firestore
        .collection("Mesajlar")
        .doc('Muvekkiller')
        .collection('Gelen Kutusu')
        .where('muvekkilID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("tarih", descending: true)
        .snapshots();

    return ref;
  }
}
