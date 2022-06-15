import 'package:chatting_app_admin/components/const.dart';
import 'package:chatting_app_admin/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ModelView extends StatefulWidget {
  const ModelView({Key? key}) : super(key: key);

  @override
  State<ModelView> createState() => _ModelViewState();
}

class _ModelViewState extends State<ModelView> {
  ScrollController con = ScrollController();

  Widget confusionMatrix(){
    return Container(
      padding: EdgeInsets.all(defaultHeight(context)/30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            child: Text(
              "Confusion Matrix",
              style: TextStyle(
                color: Colors.black,
                fontSize: defaultHeight(context)/35,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(
            height: defaultHeight(context)/40,
          ),
          Column(
            mainAxisAlignment: Responsive.isDesktop(context) ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Responsive.isDesktop(context) ?
                    defaultHeight(context)/30 + defaultWidth(context)/25 : defaultHeight(context)/25 + defaultWidth(context)/20,
                    margin: EdgeInsets.all(defaultHeight(context)/400),
                  ),
                  SizedBox(
                    width: Responsive.isDesktop(context)? defaultWidth(context)/4 : defaultWidth(context)/2.5,
                    height: defaultHeight(context)/25,
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          "NILAI SEBENARNYA",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: defaultHeight(context)/40
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
                  Container(
                    width: Responsive.isDesktop(context) ?
                    defaultHeight(context)/30 + defaultWidth(context)/25 : defaultHeight(context)/25 + defaultWidth(context)/20,
                    margin: EdgeInsets.all(defaultHeight(context)/400),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)
                    ),
                    child: Container(
                      width: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                      height: Responsive.isDesktop(context) ? defaultWidth(context)/25 : defaultWidth(context)/20,
                      margin: EdgeInsets.all(defaultHeight(context)/400),
                      color: Color(0xff50A3C6),
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            "Positif",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: defaultHeight(context)/40,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)
                    ),
                    child: Container(
                      width: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                      height: Responsive.isDesktop(context) ? defaultWidth(context)/25 : defaultWidth(context)/20,
                      margin: EdgeInsets.all(defaultHeight(context)/400),
                      color: Color(0xff50A3C6),
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            "Negatif",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: defaultHeight(context)/40,
                              color: Colors.white
                            ),
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
                    width: Responsive.isDesktop(context) ? defaultHeight(context)/30 : defaultHeight(context)/25,
                    height: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          " PREDIKSI",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: defaultHeight(context)/40
                          ),
                        ),
                      ),
                    ),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)
                    ),
                    child: Container(
                      width: Responsive.isDesktop(context) ? defaultWidth(context)/25 : defaultWidth(context)/20,
                      height: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                      margin: EdgeInsets.all(defaultHeight(context)/400),
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
                                  fontSize: defaultHeight(context)/40,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)
                    ),
                    child: Container(
                      width: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                      height: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                      margin: EdgeInsets.all(defaultHeight(context)/400),
                      color: Color(0xff2377A4),
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            "100",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: defaultHeight(context)/40,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)
                    ),
                    child: Container(
                      width: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                      height: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                      margin: EdgeInsets.all(defaultHeight(context)/400),
                      color: Color(0xff79C0D7),
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            "30",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: defaultHeight(context)/40,
                                color: Colors.white
                            ),
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
                    width: Responsive.isDesktop(context) ? defaultHeight(context)/30 : defaultHeight(context)/25,
                    height: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          "NILAI",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: defaultHeight(context)/40
                          ),
                        ),
                      ),
                    ),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)
                    ),
                    child: Container(
                      width: Responsive.isDesktop(context) ? defaultWidth(context)/25 : defaultWidth(context)/20,
                      height: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                      margin: EdgeInsets.all(defaultHeight(context)/400),
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
                                  fontSize: defaultHeight(context)/40,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)
                    ),
                    child: Container(
                      width: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                      height: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                      margin: EdgeInsets.all(defaultHeight(context)/400),
                      color: Color(0xff79C0D7),
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            "20",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: defaultHeight(context)/40,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      shadowDarkColor: Color(0xff858594)
                    ),
                    child: Container(
                      width: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                      height: Responsive.isDesktop(context) ? defaultWidth(context)/10 : defaultWidth(context)/5,
                      margin: EdgeInsets.all(defaultHeight(context)/400),
                      color: Color(0xff2377A4),
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            "85",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: defaultHeight(context)/40,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ]
      ),
    );
  }

  Widget modelInfo(){
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        depth: 2,
        lightSource: LightSource.topLeft,
        color: Colors.white70,
        shadowDarkColor: Color(0xff858594)
      ),
      child: Container(
        padding: EdgeInsets.all(defaultHeight(context)/30),
        width: Responsive.isDesktop(context) ? defaultWidth(context)/2.35 : Responsive.isTablet(context) ? defaultWidth(context)/1.45 : defaultWidth(context)/1.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: Text(
                "Informasi Model",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: defaultHeight(context)/35,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(
              height: defaultHeight(context)/40,
            ),
            Table(
              columnWidths: {
                0: FractionColumnWidth(0.3),
                1: FractionColumnWidth(0.7)
              },
              children: [
                TableRow(
                  children: [
                    SizedBox(height: defaultHeight(context)/18, child: Material(color: Colors.transparent, child: Text('Akurasi Model'))),
                    Material(color: Colors.transparent, child: Text('87%'))
                  ]
                ),
                TableRow(
                  children: [
                    SizedBox(height: defaultHeight(context)/18, child: Material(color: Colors.transparent, child: Text('Algoritma Model'))),
                    Material(color: Colors.transparent, child: Text('Bi-LSTM'))
                  ]
                ),
                TableRow(
                  children: [
                    Material(color: Colors.transparent, child: Text('Keterangan')),
                    Material(color: Colors.transparent, child: Text('Model terakhir diupdate 10 hari yang lalu oleh Admin 1'))
                  ]
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget modelFile(){
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
        depth: 2,
        lightSource: LightSource.topLeft,
        color: Colors.white70,
        shadowDarkColor: Color(0xff858594)
      ),
      child: Container(
        color: Colors.white70,
        padding: EdgeInsets.all(defaultHeight(context)/30),
        width: Responsive.isDesktop(context) ? defaultWidth(context)/2.35 : Responsive.isTablet(context) ? defaultWidth(context)/1.45 : defaultWidth(context)/1.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: Text(
                "File Model",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: defaultHeight(context)/35,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(
              height: defaultHeight(context)/40,
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
                TableRow(
                  children: [
                    Material(color: Colors.transparent, child: Text("File")),
                    Material(color: Colors.transparent, child: Text("Ukuran")),
                    Material(color: Colors.transparent, child: Text("Terakhir Diperbaharui")),
                    Material(color: Colors.transparent, child: Text("Perbaharui")),
                  ]
                ),
                TableRow(
                  children: [
                    SizedBox(height: defaultHeight(context)/50),
                    SizedBox(height: defaultHeight(context)/50),
                    SizedBox(height: defaultHeight(context)/50),
                    SizedBox(height: defaultHeight(context)/50),
                  ]
                ),
                TableRow(
                  children: [
                    Material(color: Colors.transparent, child: Text('Model')),
                    Material(color: Colors.transparent, child: Text('2.33 MB')),
                    Material(color: Colors.transparent, child: Text('9 Mar 2022, 21:11')),
                    NeumorphicButton(
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
                        "Unggah (*.md5)",
                        style: TextStyle(
                            color: Colors.white
                        )
                      )
                    ),
                  ]
                ),
                TableRow(
                  children: [
                    SizedBox(height: defaultHeight(context)/50),
                    SizedBox(height: defaultHeight(context)/50),
                    SizedBox(height: defaultHeight(context)/50),
                    SizedBox(height: defaultHeight(context)/50),
                  ]
                ),
                TableRow(
                  children: [
                    Material(color: Colors.transparent, child: Text('Pickle')),
                    Material(color: Colors.transparent, child: Text('40.25 KB')),
                    Material(color: Colors.transparent, child: Text('9 Mar 2022, 21:11')),
                    NeumorphicButton(
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
                        "Unggah (*.pickle)",
                        style: TextStyle(
                            color: Colors.white
                        )
                      )
                    ),
                  ]
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget modelView(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultWidth(context)/50, vertical: defaultHeight(context)/50),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            confusionMatrix(),
            SizedBox(
              height: defaultHeight(context)/40,
            ),
            modelInfo(),
            SizedBox(
              height: defaultHeight(context)/40,
            ),
            modelFile(),
            SizedBox(
              height: defaultHeight(context)/40,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.isDesktop(context) ? defaultHeight(context)*9/10 : defaultHeight(context),
      child: modelView(),
    );
  }
}
