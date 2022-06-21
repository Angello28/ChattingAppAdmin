import 'dart:html';

import 'package:chatting_app_admin/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app_admin/components/const.dart';
import 'package:chatting_app_admin/components/class.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatting_app_admin/Models/message_data.dart';


class DataView extends StatefulWidget {
  // const DataView({Key? key}) : super(key: key);

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  List<dynamic> _dataList = [];

  Future getDataList() async {
    var collections = await FirebaseFirestore.instance.collection('MessageData')
        .orderBy('created_at', descending: true).get();
    setState((){
      _dataList = List.from(collections.docs.map((doc) => Data.fromSnapshot(doc).toJson()));
    });
  }

  @override
  Widget build(BuildContext context) {
    getDataList();
    return Container(
      height: Responsive.isDesktop(context) ? defaultHeight(context)*9/10 : defaultHeight(context),
      padding: EdgeInsets.symmetric(horizontal: defaultWidth(context)/50, vertical: defaultHeight(context)/50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: NeumorphicButton(
              onPressed: (){},
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                depth: 2,
                lightSource: LightSource.topLeft,
                color: const Color(0xff50A3C6),
                shadowDarkColor: const Color(0xff858594)
              ),
              child: const Text(
                "Ekspor Spreadsheet (*.xlsx)",
                style: TextStyle(
                  color: Colors.white
                )
              )
            ),
          ),
          SizedBox(
            height: defaultHeight(context)/40,
          ),
          Expanded(
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                depth: 3,
                lightSource: LightSource.topLeft,
                shadowDarkColor: const Color(0xff858594)
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white70,
                      padding: EdgeInsets.symmetric(horizontal: defaultHeight(context)/30),
                      child: Column(
                        children: [
                          Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.8),
                              1: FractionColumnWidth(0.2),
                            },
                            children: [
                              TableRow(
                                children: [
                                  SizedBox(height: defaultHeight(context)/30),
                                  SizedBox(height: defaultHeight(context)/30),
                                ]
                              ),
                              TableRow(
                                children: [
                                  SizedBox(height:defaultHeight(context)/15, child: const Material(color: Colors.transparent, child: const Text("Kalimat"))),
                                  // const Material(color: Colors.transparent, child: const Text("Correction")),
                                  const Material(color: Colors.transparent, child: const Text("Label")),
                                ]
                              ),
                              for(var datum in _dataList)
                                TableRow(
                                  children: [
                                    SizedBox(
                                      height:defaultHeight(context)/15,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                           datum['message']
                                          ),
                                        )
                                      )
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: defaultWidth(context)/30,
                                          height: defaultHeight(context)/20,
                                          child: Material(
                                            child: Neumorphic(
                                              style: const NeumorphicStyle(
                                                shape: NeumorphicShape.convex,
                                                depth: -2,
                                                lightSource: LightSource.topLeft,
                                                color: Colors.white70
                                              ),
                                              child: TextField(
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                textAlignVertical: TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                                  enabledBorder: const OutlineInputBorder(
                                                    borderSide: BorderSide.none
                                                  ),
                                                  focusedBorder: const OutlineInputBorder(
                                                    borderSide: BorderSide.none
                                                  ),
                                                  disabledBorder: const OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  labelStyle: const TextStyle(
                                                    color: Colors.black
                                                  ),
                                                  enabled: false,
                                                  label: Center(child: Text(
                                                      datum['label'].toString()
                                                  )),
                                                  contentPadding: EdgeInsets.zero,
                                                ),
                                              )
                                            )
                                          )
                                        ),
                                        NeumorphicButton(
                                          onPressed: (){},
                                          style: NeumorphicStyle(
                                            shape: NeumorphicShape.convex,
                                            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                                            depth: 3,
                                            lightSource: LightSource.topLeft,
                                            color: Colors.white
                                          ),
                                          child: Icon(Icons.edit, size: defaultHeight(context)/50),
                                        )
                                      ],
                                    ),
                                  ]
                                ),
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
