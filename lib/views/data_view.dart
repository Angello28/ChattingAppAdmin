import 'dart:convert';
import 'dart:html';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' show Workbook;
import 'package:chatting_app_admin/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app_admin/components/const.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatting_app_admin/Models/message_data.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

class DataView extends StatefulWidget {
  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  List<dynamic> _dataList = [];
  Map<String, String> _dataMap = {};

  @override
  void initState(){
    super.initState();
    getDataList();
  }

  Future getDataList() async {
    var collections = await FirebaseFirestore.instance
        .collection('MessageData')
        .orderBy('created_at', descending: true)
        .get();
    setState(() {
      _dataList = List.from(
          collections.docs.map((doc) => Data.fromSnapshot(doc).toJson()));
    });
  }

  Future exportExcel() async {
    final Workbook workbook = Workbook();
    final sheet = workbook.worksheets[0];

    int count = 2;
    sheet.getRangeByName('A1').setText('Kalimat');
    sheet.getRangeByName('B1').setText('Label');
    sheet.getRangeByName('C1').setText('Koreksi');
    for (var datum in _dataList) {
      sheet.getRangeByName('A$count').setText(datum['message']);
      sheet.getRangeByName('B$count').setNumber(datum['label']);
      sheet.getRangeByName('C$count').setNumber(datum['correction']);
      count++;
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if (kIsWeb) {
      AnchorElement(
          href:
              'data:application/octet-stream;charset=utf-16le;base64,${base64Encode(bytes)}')
        ..setAttribute('download', 'Output.xlsx')
        ..click();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.isDesktop(context)
          ? defaultHeight(context) * 9 / 10
          : defaultHeight(context),
      padding: EdgeInsets.symmetric(
          horizontal: defaultWidth(context) / 50,
          vertical: defaultHeight(context) / 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: NeumorphicButton(
                onPressed: exportExcel,
                style: NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                    depth: 2,
                    lightSource: LightSource.topLeft,
                    color: const Color(0xff50A3C6),
                    shadowDarkColor: const Color(0xff858594)),
                child: const Text("Ekspor Spreadsheet (*.xlsx)",
                    style: TextStyle(color: Colors.white))),
          ),
          SizedBox(
            height: defaultHeight(context) / 40,
          ),
          Expanded(
            child: Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                  depth: 3,
                  lightSource: LightSource.topLeft,
                  shadowDarkColor: const Color(0xff858594)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white70,
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultHeight(context) / 30),
                      child: Column(
                        children: [
                          Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.6),
                              1: FractionColumnWidth(0.2),
                              2: FractionColumnWidth(0.2),
                            },
                            children: [
                              TableRow(children: [
                                SizedBox(height: defaultHeight(context) / 30),
                                SizedBox(height: defaultHeight(context) / 30),
                                SizedBox(height: defaultHeight(context) / 30),
                              ]),
                              TableRow(children: [
                                SizedBox(
                                  height: defaultHeight(context) / 15,
                                  child: const Material(
                                    color: Colors.transparent,
                                    child: const Text("Kalimat"))),
                                // const Material(color: Colors.transparent, child: const Text("Correction")),
                                const Material(
                                  color: Colors.transparent,
                                  child: const Text("Tingkat kasar(%)")),
                                const Material(
                                  color: Colors.transparent,
                                  child: const Text("Label")),
                              ]),
                              for (var datum in _dataList)
                                TableRow(children: [
                                  SizedBox(
                                    height: defaultHeight(context) / 15,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(datum['message']),
                                      ))),
                                  SizedBox(
                                    height: defaultHeight(context) / 15,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("75%"),
                                      ))
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: defaultWidth(context) / 30,
                                          height: defaultHeight(context) / 20,
                                          child: Material(
                                              child: Neumorphic(
                                                  style: const NeumorphicStyle(
                                                      shape: NeumorphicShape
                                                          .convex,
                                                      depth: -2,
                                                      lightSource:
                                                          LightSource.topLeft,
                                                      color: Colors.white70),
                                                  child: TextField(
                                                    maxLines: 1,
                                                    maxLength: 1,
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp("[0-1]")),
                                                    ],
                                                    textAlign: TextAlign.center,
                                                    onChanged: (content) {
                                                      setState(() {
                                                        if (content
                                                            .isNotEmpty) {
                                                          datum['correction'] =
                                                              content;
                                                          _dataMap[datum['id']] = datum['correction'];
                                                        }
                                                      });
                                                    },
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    decoration: InputDecoration(
                                                      counterText: '',
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .never,
                                                      enabledBorder:
                                                          const OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      disabledBorder:
                                                          const OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.black),
                                                      enabled: true,
                                                      label: Center(
                                                          child: Text(datum[
                                                                  'correction']
                                                              .toString())),
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                    ),
                                                  )))),
                                      NeumorphicButton(
                                        onPressed: () {
                                          setState(() {
                                            final docUser = FirebaseFirestore
                                                .instance
                                                .collection('MessageData')
                                                .doc(datum['id']);
                                            final correction = int.parse(
                                                _dataMap[datum['id']]
                                                    .toString());

                                            docUser.update(
                                                {'correction': correction});
                                          });
                                        },
                                        style: NeumorphicStyle(
                                            shape: NeumorphicShape.convex,
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(50)),
                                            depth: 3,
                                            lightSource: LightSource.topLeft,
                                            color: Colors.white),
                                        child: Icon(Icons.edit,
                                            size: defaultHeight(context) / 50),
                                      )
                                    ],
                                  ),
                                ]),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
