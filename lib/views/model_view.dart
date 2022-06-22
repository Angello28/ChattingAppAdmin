import 'dart:html';
import 'package:chatting_app_admin/Models/model.dart';
import 'package:chatting_app_admin/components/const.dart';
import 'package:chatting_app_admin/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatting_app_admin/Models/message_data.dart';
import 'package:intl/intl.dart';


class ModelView extends StatefulWidget {
  const ModelView({Key? key}) : super(key: key);

  @override
  State<ModelView> createState() => _ModelViewState();
}

class _ModelViewState extends State<ModelView> {
  ScrollController con = ScrollController();
  PlatformFile? pickedFile;
  List<dynamic> _dataList = [];
  List<dynamic> _modelList = [];
  int truePositive = 0;
  int trueNegative = 0;
  int falsePositive = 0;
  int falseNegative = 0;
  double accuracy = 0;
  String modelSize = 'MB';
  DateTime modelDate = DateTime.now();
  String pickleSize = 'MB';
  DateTime pickleDate = DateTime.now();

  @override
  void initState(){
    super.initState();
    getData();
  }

  Future getData() async {
    var collections = await FirebaseFirestore.instance
        .collection('MessageData')
        .orderBy('created_at', descending: true)
        .get();

    var modelCollections = await FirebaseFirestore.instance
        .collection('Model')
        .get();

    setState(() {
      _dataList = List.from(
          collections.docs.map((doc) => Data.fromSnapshot(doc).toJson()));
      _modelList = List.from(
        modelCollections.docs.map((doc) => Model.fromSnapshot(doc).toJson()));
      for (var data in _modelList) {
        String unit = 'KB';
        double kb = double.parse(data['size'].toStringAsExponential(2));
        if (kb > 1000.0) {
          unit = 'MB';
          kb  = (kb / 1000);
        }
        if (data['id'] == 'pickle') {
          pickleSize = '$kb $unit';
          pickleDate = data['date'];
        } else if (data['id'] == 'model') {
          modelSize = '$kb $unit';
          modelDate = data['date'];
        }
      }
    });

    updateData();
  }

  void updateData() {
    for (var data in _dataList) {
      var correction = data['correction'];
      var label = data['label'];
      if (correction == 0 && label == 0) {
        truePositive+=1;
      } else if (correction == 1 && label == 1) {
        trueNegative+=1;
      } else if (correction == 1 && label == 0) {
        falsePositive+=1;
      } else if (correction == 0 && label == 1) {
        falseNegative+=1;
      }
    }
    accuracy = (((truePositive + trueNegative) / (truePositive + trueNegative + falseNegative + falsePositive)) * 100);
  }
  
  Future uploadTokenizer() async {
    final _files = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pickle'],
        allowMultiple: false,
        allowCompression: false));
    if (_files == null) {
      return;
    }
    setState(() {
      pickedFile = _files.files.first;
    });

    final extension = pickedFile!.extension;
    if (extension == 'pickle') {
      final path = "profanityModel/tokenizer.pickle";
      final ref = FirebaseStorage.instance.ref().child(path);
      ref.putData(pickedFile!.bytes!);
    } else {
      return;
    }
    setState(() {
      final docModel = FirebaseFirestore
          .instance
          .collection('Model')
          .doc('pickle');
      double kb = (pickedFile!.size / 1000);
      docModel.update({
        'size': kb,
        'date' : DateTime.now().toLocal()
      });
      String unit = 'KB';
      if (kb > 1000.0) {
        unit = 'MB';
        kb  = (kb / 1000);
      }

      var byteSize = double.parse(kb.toStringAsExponential(2));
      pickleSize = '$byteSize $unit';
      pickleDate = DateTime.now().toLocal();
    });
  }

  Future uploadH5File() async {
    final _files = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['h5', 'hdf5'],
        allowMultiple: false,
        allowCompression: false));
    if (_files == null) {
      return;
    }
    setState(() {
      pickedFile = _files.files.first;
    });

    final extension = pickedFile!.extension;
    if (extension == 'h5' || extension == 'hdf5') {
      final path = "profanityModel/model.h5";
      final ref = FirebaseStorage.instance.ref().child(path);
      ref.putData(pickedFile!.bytes!);
    } else {
      return;
    }

    setState(() {
      final docModel = FirebaseFirestore
          .instance
          .collection('Model')
          .doc('model');
      double kb = pickedFile!.size / 1000;
      docModel.update({
        'size': kb,
        'date' : DateTime.now().toLocal()
      });
      String unit = 'KB';
      if (kb > 1000.0) {
        unit = 'MB';
        kb  = (kb / 1000);
      }
      var byteSize = double.parse(kb.toStringAsExponential(2));
      modelSize = '$byteSize $unit';
      modelDate = DateTime.now().toLocal();
    });
  }

  Widget confusionMatrix() {
    return Container(
      padding: EdgeInsets.all(defaultHeight(context) / 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Material(
          color: Colors.transparent,
          child: Text(
            "Confusion Matrix",
            style: TextStyle(
                color: Colors.black,
                fontSize: defaultHeight(context) / 35,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: defaultHeight(context) / 40,
        ),
        Column(
          mainAxisAlignment: Responsive.isDesktop(context)
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Responsive.isDesktop(context)
                      ? defaultHeight(context) / 30 + defaultWidth(context) / 25
                      : defaultHeight(context) / 25 +
                          defaultWidth(context) / 20,
                  margin: EdgeInsets.all(defaultHeight(context) / 400),
                ),
                SizedBox(
                  width: Responsive.isDesktop(context)
                      ? defaultWidth(context) / 4
                      : defaultWidth(context) / 2.5,
                  height: defaultHeight(context) / 25,
                  child: Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        "NILAI SEBENARNYA",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: defaultHeight(context) / 40),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Responsive.isDesktop(context)
                      ? defaultHeight(context) / 30 + defaultWidth(context) / 25
                      : defaultHeight(context) / 25 +
                          defaultWidth(context) / 20,
                  margin: EdgeInsets.all(defaultHeight(context) / 400),
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)),
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 10
                        : defaultWidth(context) / 5,
                    height: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 25
                        : defaultWidth(context) / 20,
                    margin: EdgeInsets.all(defaultHeight(context) / 400),
                    color: Color(0xff50A3C6),
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          "Positif",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: defaultHeight(context) / 40,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)),
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 10
                        : defaultWidth(context) / 5,
                    height: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 25
                        : defaultWidth(context) / 20,
                    margin: EdgeInsets.all(defaultHeight(context) / 400),
                    color: Color(0xff50A3C6),
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          "Negatif",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: defaultHeight(context) / 40,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Responsive.isDesktop(context)
                      ? defaultHeight(context) / 30
                      : defaultHeight(context) / 25,
                  height: Responsive.isDesktop(context)
                      ? defaultWidth(context) / 10
                      : defaultWidth(context) / 5,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        " PREDIKSI",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: defaultHeight(context) / 40),
                      ),
                    ),
                  ),
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)),
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 25
                        : defaultWidth(context) / 20,
                    height: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 10
                        : defaultWidth(context) / 5,
                    margin: EdgeInsets.all(defaultHeight(context) / 400),
                    color: Color(0xff50A3C6),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            "Positif",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: defaultHeight(context) / 40,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)),
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 10
                        : defaultWidth(context) / 5,
                    height: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 10
                        : defaultWidth(context) / 5,
                    margin: EdgeInsets.all(defaultHeight(context) / 400),
                    color: Color(0xff2377A4),
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          truePositive.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: defaultHeight(context) / 40,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)),
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 10
                        : defaultWidth(context) / 5,
                    height: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 10
                        : defaultWidth(context) / 5,
                    margin: EdgeInsets.all(defaultHeight(context) / 400),
                    color: Color(0xff79C0D7),
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          falsePositive.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: defaultHeight(context) / 40,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Responsive.isDesktop(context)
                      ? defaultHeight(context) / 30
                      : defaultHeight(context) / 25,
                  height: Responsive.isDesktop(context)
                      ? defaultWidth(context) / 10
                      : defaultWidth(context) / 5,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        "NILAI",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: defaultHeight(context) / 40),
                      ),
                    ),
                  ),
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)),
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 25
                        : defaultWidth(context) / 20,
                    height: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 10
                        : defaultWidth(context) / 5,
                    margin: EdgeInsets.all(defaultHeight(context) / 400),
                    color: Color(0xff50A3C6),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            "Negatif",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: defaultHeight(context) / 40,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)),
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 10
                        : defaultWidth(context) / 5,
                    height: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 10
                        : defaultWidth(context) / 5,
                    margin: EdgeInsets.all(defaultHeight(context) / 400),
                    color: Color(0xff79C0D7),
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          falseNegative.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: defaultHeight(context) / 40,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)),
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 10
                        : defaultWidth(context) / 5,
                    height: Responsive.isDesktop(context)
                        ? defaultWidth(context) / 10
                        : defaultWidth(context) / 5,
                    margin: EdgeInsets.all(defaultHeight(context) / 400),
                    color: Color(0xff2377A4),
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          trueNegative.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: defaultHeight(context) / 40,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ]),
    );
  }

  Widget modelInfo() {
    return Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
          depth: 2,
          lightSource: LightSource.topLeft,
          color: Colors.white70,
          shadowDarkColor: Color(0xff858594)),
      child: Container(
        padding: EdgeInsets.all(defaultHeight(context) / 30),
        width: Responsive.isDesktop(context)
            ? defaultWidth(context) / 2.35
            : Responsive.isTablet(context)
                ? defaultWidth(context) / 1.45
                : defaultWidth(context) / 1.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: Text(
                "Informasi Model",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: defaultHeight(context) / 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: defaultHeight(context) / 40,
            ),
            Table(
              columnWidths: {
                0: FractionColumnWidth(0.3),
                1: FractionColumnWidth(0.7)
              },
              children: [
                TableRow(children: [
                  SizedBox(
                      height: defaultHeight(context) / 18,
                      child: Material(
                          color: Colors.transparent,
                          child: Text('Akurasi Model'))),
                  Material(color: Colors.transparent, child: Text('${accuracy.toString()}%'))
                ]),
                TableRow(children: [
                  SizedBox(
                      height: defaultHeight(context) / 18,
                      child: Material(
                          color: Colors.transparent,
                          child: Text('Algoritma Model'))),
                  Material(color: Colors.transparent, child: Text('Bi-LSTM'))
                ]),
                TableRow(children: [
                  Material(
                      color: Colors.transparent, child: Text('Keterangan')),
                  Material(
                      color: Colors.transparent,
                      child: Text(
                          'Model terakhir diupdate ${DateTime.now().toLocal().difference(modelDate.toLocal()).inDays.toString()} hari yang lalu oleh Admin 1'))
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget modelFile() {
    return Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
          depth: 2,
          lightSource: LightSource.topLeft,
          color: Colors.white70,
          shadowDarkColor: Color(0xff858594)),
      child: Container(
        color: Colors.white70,
        padding: EdgeInsets.all(defaultHeight(context) / 30),
        width: Responsive.isDesktop(context)
            ? defaultWidth(context) / 2.35
            : Responsive.isTablet(context)
                ? defaultWidth(context) / 1.45
                : defaultWidth(context) / 1.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: Text(
                "File Model",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: defaultHeight(context) / 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: defaultHeight(context) / 40,
            ),
            Table(
              columnWidths: {
                0: FractionColumnWidth(0.12),
                1: FractionColumnWidth(0.16),
                2: FractionColumnWidth(0.32),
                3: IntrinsicColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  Material(color: Colors.transparent, child: Text("File")),
                  Material(color: Colors.transparent, child: Text("Ukuran")),
                  Material(
                      color: Colors.transparent,
                      child: Text("Terakhir Diperbaharui")),
                  Material(
                      color: Colors.transparent, child: Text("Perbaharui")),
                ]),
                TableRow(children: [
                  SizedBox(height: defaultHeight(context) / 50),
                  SizedBox(height: defaultHeight(context) / 50),
                  SizedBox(height: defaultHeight(context) / 50),
                  SizedBox(height: defaultHeight(context) / 50),
                ]),
                TableRow(children: [
                  Material(color: Colors.transparent, child: Text('Model')),
                  Material(color: Colors.transparent, child: Text(modelSize)),
                  Material(
                      color: Colors.transparent,
                      child: Text(DateFormat('dd-MM-yyyy, HH:mm').format(modelDate.toLocal()).toString())),
                  NeumorphicButton(
                      onPressed: uploadH5File,
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(10)),
                          depth: 2,
                          lightSource: LightSource.topLeft,
                          color: Color(0xff50A3C6),
                          shadowDarkColor: Color(0xff858594)),
                      child: Text("Unggah (*.h5)",
                          style: TextStyle(color: Colors.white))),
                ]),
                TableRow(children: [
                  SizedBox(height: defaultHeight(context) / 50),
                  SizedBox(height: defaultHeight(context) / 50),
                  SizedBox(height: defaultHeight(context) / 50),
                  SizedBox(height: defaultHeight(context) / 50),
                ]),
                TableRow(children: [
                  Material(color: Colors.transparent, child: Text('Pickle')),
                  Material(color: Colors.transparent, child: Text(pickleSize)),
                  Material(
                      color: Colors.transparent,
                      child: Text(DateFormat('dd-MM-yyyy, HH:mm').format(pickleDate.toLocal()).toString())),
                  NeumorphicButton(
                      onPressed: uploadTokenizer,
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.convex,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(10)),
                          depth: 2,
                          lightSource: LightSource.topLeft,
                          color: Color(0xff50A3C6),
                          shadowDarkColor: Color(0xff858594)),
                      child: Text("Unggah (*.pickle)",
                          style: TextStyle(color: Colors.white))),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget modelView() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: defaultWidth(context) / 50,
          vertical: defaultHeight(context) / 50),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            confusionMatrix(),
            SizedBox(
              height: defaultHeight(context) / 40,
            ),
            modelInfo(),
            SizedBox(
              height: defaultHeight(context) / 40,
            ),
            modelFile(),
            SizedBox(
              height: defaultHeight(context) / 40,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.isDesktop(context)
          ? defaultHeight(context) * 9 / 10
          : defaultHeight(context),
      child: modelView(),
    );
  }
}
