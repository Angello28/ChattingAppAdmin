import 'package:chatting_app_admin/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app_admin/components/const.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'main_view.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.isDesktop(context) ? defaultWidth(context)/3 : defaultWidth(context)/5),
      decoration: BoxDecoration(
        color: Color(0xffecf0f3),
        image: DecorationImage(
          image: AssetImage("login_background.png"),
          fit: BoxFit.cover
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NeumorphicIcon(
            Icons.admin_panel_settings_outlined,
            size: Responsive.isDesktop(context)? defaultWidth(context)/10 : defaultWidth(context)/4,
            style: NeumorphicStyle(
              shape: NeumorphicShape.convex,
              depth: 3,
              intensity: 0.7,
              color: Color(0xff2377A4),
              lightSource: LightSource.topLeft,
              shadowDarkColor: Color(0xff858594)
            ),
          ),
          SizedBox(
            height: defaultHeight(context)/25,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: defaultHeight(context)/10,
                  child: Material(
                    color: Colors.transparent,
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        depth: -2,
                        lightSource: LightSource.topLeft,
                        color: Colors.white70
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          color: Color(0xff2377A4)
                        ),
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xff2377A4)
                          ),
                          labelText: "Nama Admin",
                          contentPadding: EdgeInsets.symmetric(vertical: defaultHeight(context)/20, horizontal: defaultWidth(context)/50)
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: defaultHeight(context)/25,
                ),
                SizedBox(
                  height: defaultHeight(context)/10,
                  child: Material(
                    color: Colors.transparent,
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        depth: -2,
                        lightSource: LightSource.topLeft,
                        color: Colors.white70
                      ),
                      child: TextFormField(
                        obscureText: isObscure,
                        style: TextStyle(
                          color: Color(0xff2377A4)
                        ),
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xff2377A4)
                          ),
                          labelText: "Kata Sandi",
                          suffix: InkWell(
                            child: Icon(
                              isObscure ? Icons.visibility : Icons.visibility_off,
                              color: Color(0xff2377A4),
                            ),
                            onTap: (){
                              setState((){
                                isObscure = !isObscure;
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: defaultHeight(context)/20, horizontal: defaultWidth(context)/50),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: defaultHeight(context)/25,
          ),
          SizedBox(
            width: Responsive.isDesktop(context) ? defaultWidth(context)/5 : defaultWidth(context)/3,
            height: defaultHeight(context)/15,
            child: NeumorphicButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainView())),
              child: Center(
                child: const Text(
                  "M A S U K",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                depth: 2,
                lightSource: LightSource.topLeft,
                color: Color(0xff50A3C6),
                shadowDarkColor: Color(0xff858594)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
