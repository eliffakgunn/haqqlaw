import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haqqlaw/randevu_islemleri_muvekkil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RandevuOlusturMuvekkil(),
    );
  }
}

class RandevuOlusturMuvekkil extends StatefulWidget {
  @override
  _RandevuOlusturMuvekkilState createState() => _RandevuOlusturMuvekkilState();
}

class _RandevuOlusturMuvekkilState extends State<RandevuOlusturMuvekkil> {
  Future<bool> onBackPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => RandevuIslemleriMuvekkil()));
    return Future<bool>.value(true);
  }

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
  String currLawyer = 'esra akgün';

  String catType = 'Online';
  List<String> types = ['Online', 'Ofiste'];

  List<String> hour = [
    '08.00',
    '09.00',
    '10.00',
    '11.00',
    '13.00',
    '14.00',
    '15.00',
    '16.00'
  ];
  String currHour = '08.00';

  /*int currHour = 08;
  List<int> hour = [08, 09, 10, 11, 13, 14, 15, 16];*/

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    /*int index = hour.indexOf('15.00');
    hour.removeAt(index);*/
    updateLawyers();
    //updateHours();
    super.initState();
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
                      width: 60,
                    ),
                    Text(
                      "Randevu Oluştur",
                      style: TextStyle(
                          fontSize: 25,
                          color: HexColor("#23435E"),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Kategori:",
                          style: TextStyle(
                              fontSize: 16, color: HexColor("#23435E")),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 56),
                      Container(
                        height: 40,
                        width: 265,
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
                /*SizedBox(
                  height: 5,
                ),*/
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Avukat:",
                          style: TextStyle(
                              fontSize: 16, color: HexColor("#23435E")),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 66),
                      Container(
                        height: 40,
                        width: 250,
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
                            updateHours();
                            for (String s in hour) {
                              print('saat = ' + s);
                            }
                          },
                          value: currLawyer,
                        ),
                      ),
                    ],
                  ),
                ),
                /*SizedBox(
                  height: 5,
                ),*/
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Randevu Şekli:",
                          style: TextStyle(
                              fontSize: 16, color: HexColor("#23435E")),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        height: 40,
                        width: 250,
                        alignment: Alignment.topLeft,
                        child: DropdownButton<String>(
                          items: types.map((String dropDownString) {
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
                              this.catType = newValue!;
                            });
                          },
                          value: catType,
                        ),
                      ),
                    ],
                  ),
                ),
                /*SizedBox(
                  height: 7,
                ),*/
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Tarih:",
                        style:
                            TextStyle(fontSize: 16, color: HexColor("#23435E")),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 65,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 250,
                        child: FormBuilderDateTimePicker(
                          name: "date",
                          onChanged: (dt) {
                            setState(() {
                              this.selectedDate = dt!;
                            });
                            updateHours();
                          },
                          initialValue: DateTime.now(),
                          fieldHintText: "Add Date",
                          initialDatePickerMode: DatePickerMode.day,
                          inputType: InputType.date,
                          format: DateFormat('dd/MM/yyyy'),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*SizedBox(
                  height: 5,
                ),*/
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Saat:",
                          style: TextStyle(
                              fontSize: 16, color: HexColor("#23435E")),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 80),
                      Container(
                        height: 40,
                        width: 250,
                        alignment: Alignment.topLeft,
                        child: DropdownButton<String>(
                          items: hour.map((String dropDownString) {
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
                              this.currHour = newValue!;
                            });
                          },
                          value: currHour,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: HexColor("#23435E"),
                      borderRadius: BorderRadius.circular(7)),
                  child: FlatButton(
                    onPressed: () async {
                      saveAppointment();
                    },
                    child: Text(
                      'Kaydet',
                      style:
                          TextStyle(color: HexColor("#d1dbe2"), fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void updateHours() {
    var snapshot = _firestore
        .collection('Randevular')
        .doc('Randevular')
        .collection(currLawyer)
        .where('tarihSaatsiz', isEqualTo: selectedDate)
        .get();

    snapshot.then((value2) => setState(() {
          for (QueryDocumentSnapshot q in value2.docs) {
            int index = hour.indexOf(q.data()['saat']);
            this.hour.removeAt(index);
          }
        }));
  }

  void saveAppointment() {
    Map<String, int> map = {
      '08.00': 08,
      '09.00': 09,
      '10.00': 10,
      '11.00': 11,
      '13.00': 13,
      '14.00': 14,
      '15.00': 15,
      '16.00': 16
    };

    int hour = map[this.currHour] as int;
    DateTime time = new DateTime(
        this.selectedDate.year,
        this.selectedDate.month,
        this.selectedDate.day,
        hour,
        this.selectedDate.minute,
        this.selectedDate.second,
        this.selectedDate.millisecond,
        this.selectedDate.microsecond);

    print('selectedDate.hour = ' + selectedDate.hour.toString());
    print('selectedDate.minute = ' + selectedDate.minute.toString());

    DocumentReference docID = _firestore
        .collection("Randevular")
        .doc('Randevular')
        .collection(currLawyer)
        .doc();

    var collection = _firestore
        .collection('Kullanıcılar')
        .doc('Müvekkiller')
        .collection('Müvekkiller');
    var docSnapshot =
        collection.doc(FirebaseAuth.instance.currentUser!.uid).get();

    docSnapshot.then((value) => setState(() {
          String muvekkilAdi = value.data()!['adi'];

          docID.set({
            'avukat': currLawyer,
            'kategori': currCategory,
            'tarihSaatli': time,
            'tarihSaatsiz': selectedDate,
            'saat': currHour,
            'muvekkilID': FirebaseAuth.instance.currentUser!.uid,
            'muvekkilAdi': muvekkilAdi
          });

          var snapshot = _firestore
              .collection('Kullanıcılar')
              .doc('Avukatlar')
              .collection('Avukatlar')
              .where('adi', isEqualTo: currLawyer)
              .get();

          snapshot.then((value2) => setState(() {
                docID.update({
                  'avukatID': value2.docs.first.id,
                }).then((value1) => print("doc ekkendi"));
              }));

          Fluttertoast.showToast(
              msg: 'Randevunuz oluşturuldu.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM);
        }));
  }

  void convertHourMin() {
    Map<String, int> map = {
      '08.00': 08,
      '09.00': 09,
      '10.00': 10,
      '11.00': 11,
      '13.00': 13,
      '14.00': 14,
      '15.00': 15,
      '16.00': 16
    };

    int hour = map[this.currHour] as int;
    DateTime time = new DateTime(
        this.selectedDate.year,
        this.selectedDate.month,
        this.selectedDate.day,
        hour,
        this.selectedDate.minute,
        this.selectedDate.second,
        this.selectedDate.millisecond,
        this.selectedDate.microsecond);
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

    updateHours();
  }
}
