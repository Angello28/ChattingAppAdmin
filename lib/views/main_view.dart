import 'package:chatting_app_admin/components/const.dart';
import 'package:chatting_app_admin/components/responsive.dart';
import 'package:chatting_app_admin/views/model_view.dart';
import 'package:chatting_app_admin/views/data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'login_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool isModelView = true;
  double neumorphicDepthModel = -3;
  double neumorphicDepthData = 0;

  Widget widgetView(){
    if(isModelView){
      return ModelView();
    }
    else{
      return DataView();
    }
  }

  Widget sideBar(){
    return Container(
      height: defaultHeight(context),
      width: Responsive.isTablet(context) ? defaultWidth(context)/4 : defaultWidth(context)/2.5,
      padding: EdgeInsets.symmetric(horizontal: defaultWidth(context)/45, vertical: defaultHeight(context)/25),
      color: Color(0xff2377A4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: Responsive.isTablet(context) ? defaultWidth(context)/15 : defaultWidth(context)/10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: Responsive.isTablet(context) ? defaultWidth(context)/15 : defaultWidth(context)/10,
                      color: Colors.white,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        "Admin 1",
                        style: TextStyle(
                          fontSize: Responsive.isTablet(context) ? defaultWidth(context)/45 : defaultWidth(context)/30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Responsive.isDesktop(context) ? defaultWidth(context)/40 : defaultWidth(context)/60,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: defaultHeight(context)/20,
              ),
              Neumorphic(
                style: NeumorphicStyle(
                  shape: isModelView ? NeumorphicShape.convex : NeumorphicShape.flat,
                  color: Color(0xff2377A4),
                  depth: neumorphicDepthModel,
                  lightSource: LightSource.topLeft,
                  shadowLightColor: Color(0xff2a90c6),
                  shadowDarkColor: Color(0xff164c69)
                ),
                child: Material(
                  color: Color(0xff2377A4),
                  child: ListTile(
                    leading: Icon(
                      Icons.memory,
                      color: Colors.white,
                      size: isModelView ? defaultHeight(context)/27 : defaultHeight(context)/25,
                    ),
                    title: Text(
                      "Model",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: isModelView ? defaultHeight(context)/42 : defaultHeight(context)/40
                      ),
                    ),
                    onTap: (){
                      setState((){
                        isModelView = true;
                        neumorphicDepthModel = -3;
                        neumorphicDepthData = 0;
                        if(Responsive.isMobile(context)){
                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: defaultHeight(context)/100,
              ),
              Neumorphic(
                style: NeumorphicStyle(
                  shape: !isModelView ? NeumorphicShape.convex : NeumorphicShape.flat,
                  color: Color(0xff2377A4),
                  depth: neumorphicDepthData,
                  lightSource: LightSource.topLeft,
                  shadowLightColor: Color(0xff2a90c6),
                  shadowDarkColor: Color(0xff164c69)
                ),
                child: Material(
                  color: Color(0xff2377A4),
                  child: ListTile(
                    leading: Icon(
                      Icons.table_view,
                      color: Colors.white,
                      size: !isModelView ? defaultHeight(context)/27 : defaultHeight(context)/25,
                    ),
                    title: Text(
                      "Data",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: !isModelView ? defaultHeight(context)/42 : defaultHeight(context)/40
                      ),
                    ),
                    onTap: (){
                      setState((){
                        isModelView = false;
                        neumorphicDepthModel = 0;
                        neumorphicDepthData = -3;
                        if(Responsive.isMobile(context)){
                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text(
                "Keluar",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()))
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Scaffold(
        drawer: sideBar(),
        backgroundColor: Color(0xffecf0f3),
        appBar: AppBar(
          backgroundColor: Color(0xffecf0f3),
          elevation: 0,
          leading: Builder(
            builder: (context){
              return NeumorphicButton(
                margin: EdgeInsets.all(defaultHeight(context)/100),
                padding: EdgeInsets.all(defaultHeight(context)/70),
                onPressed: (){
                  Scaffold.of(context).openDrawer();
                },
                child: Center(child: Icon(Icons.menu, color: Colors.black)),
                style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                  depth: 3,
                  lightSource: LightSource.topLeft,
                  color: Color(0xffecf0f3)
                ),
              );
            },
          ),
          title: Material(
            color: Colors.transparent,
            child: Text(
              isModelView ? "Model" : "Data",
              style: TextStyle(
                fontSize: defaultWidth(context)/30,
                color: Colors.black,
              )
            )
          ),
        ),
        body: widgetView(),
      ),
      desktop: Container(
        color: Color(0xffecf0f3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: defaultWidth(context)/50, vertical: defaultHeight(context)/50),
                height: defaultHeight(context)/10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: defaultWidth(context)/12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.account_circle, size: defaultWidth(context)/50),
                          Material(
                            color: Colors.transparent,
                            child: Text(
                              "Admin 1",
                              style: TextStyle(
                                fontSize: defaultWidth(context)/80,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: defaultWidth(context)/50),
                    NeumorphicButton(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login())),
                      child: Center(child: Icon(Icons.logout, size: defaultHeight(context)/45, color: Colors.white)),
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                        depth: 2,
                        lightSource: LightSource.topLeft,
                        shadowDarkColor: Color(0xff858594),
                        color: Colors.red
                      ),
                    )
                  ],
                ),
              ),
              visible: Responsive.isDesktop(context),
              maintainSize: false,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  child: sideBar(),
                  visible: Responsive.isTablet(context),
                  maintainSize: false,
                ),
                Expanded(child: Responsive.isDesktop(context) ? ModelView() : widgetView()),
                Visibility(
                  child: Expanded(child: DataView()),
                  visible: Responsive.isDesktop(context),
                  maintainSize: false,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
