import 'package:chatting_app_admin/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app_admin/components/const.dart';
import 'package:chatting_app_admin/components/class.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class DataView extends StatefulWidget {
  const DataView({Key? key}) : super(key: key);

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {

  @override
  Widget build(BuildContext context) {
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
                color: Color(0xff50A3C6),
                shadowDarkColor: Color(0xff858594)
              ),
              child: Text(
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
                shadowDarkColor: Color(0xff858594)
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
                            columnWidths: {
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
                                  SizedBox(height:defaultHeight(context)/15, child: Material(color: Colors.transparent, child: Text("Kalimat"))),
                                  Material(color: Colors.transparent, child: Text("Label")),
                                ]
                              ),
                              for(var data in listData)
                                TableRow(
                                  children: [
                                    SizedBox(
                                      height:defaultHeight(context)/15,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            data.message
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
                                              style: NeumorphicStyle(
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
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none
                                                  ),
                                                  disabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  labelStyle: TextStyle(
                                                    color: Colors.black
                                                  ),
                                                  enabled: false,
                                                  label: Center(child: Text(data.label)),
                                                  contentPadding: EdgeInsets.zero,
                                                ),
                                              )
                                            )
                                          )
                                        ),
                                        NeumorphicButton(
                                          onPressed: (){},
                                          child: Icon(Icons.edit, size: defaultHeight(context)/50),
                                          style: NeumorphicStyle(
                                            shape: NeumorphicShape.convex,
                                            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                                            depth: 3,
                                            lightSource: LightSource.topLeft,
                                            color: Colors.white
                                          ),
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
