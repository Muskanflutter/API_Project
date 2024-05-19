import 'dart:async';

import 'package:api_project/Be%20Grateful/Login_Page.dart';
import 'package:api_project/Be%20Grateful/Login_Signup.dart';
import 'package:flutter/material.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  Widget build(BuildContext context) {
      Timer(Duration(seconds: 2),(){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Login_Signup()),
        );
      });
    return Scaffold(
      body: Center(
        child: ClipOval(
          child:  Image.asset("Img/img.png",fit: BoxFit.cover,),
        ),
      ),
    );
  }
}
