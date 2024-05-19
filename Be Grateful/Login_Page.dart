import 'dart:convert';

import 'package:api_project/Be%20Grateful/Login_Signup.dart';
import 'package:api_project/Be%20Grateful/Social_Page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("Img/img_2.png"),
                fit: BoxFit.cover,),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                height: 550,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                  // borderRadius: BorderRadius.only(
                  //   // topRight: Radius.circular(40),
                  //   // topLeft: Radius.circular(40),
                  // ),
                ),
                child: Column(
                  children: [
                    Text("Welcome",style: TextStyle(fontSize: 40,color: Colors.white,),),
                    Text("Sign in to Continue"),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: Text("Login",style: TextStyle(color: Colors.purple.shade300,fontSize: 30),),
                    ),
                    SizedBox(height: 40,),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text("Email",style: TextStyle(color: Colors.white),),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: password,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: Icon(Icons.lock,color: Colors.black,),
                        label: Text("Password",style: TextStyle(color: Colors.white),),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 200,bottom: 10),
                      child: TextButton(onPressed: (){
                        print("I forgot my password");
                      }, child: Text("Forgot Password?")),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                              colors: [Color.fromARGB(243, 3, 175, 26),Colors.blue])),
                      child: ElevatedButton(
                          onPressed: () async {
                            var em = email.text.toString();
                            var pass = password.text.toString();

                            Uri url = Uri.parse("https://begratefulapp.ca/api/login");
                            var param ={
                              "name": em.toString(),
                              "password": pass.toString(),
                              "device_token":"12345678",
                              "device_os":"android"
                            };
                            var res = await http.post(url,body: param);
                            if(res.statusCode==200)
                              {
                                var json=jsonDecode(res.body.toString());
                               if(json["result"]=="success")
                                 {
                                   Fluttertoast.showToast(
                                       msg: json["message"],
                                       toastLength: Toast.LENGTH_SHORT,
                                       gravity: ToastGravity.BOTTOM,
                                       timeInSecForIosWeb: 1,
                                       backgroundColor: Colors.red,
                                       textColor: Colors.white,
                                       fontSize: 16.0);
                                   var id = json["data"]["id"].toString();
                                   var nam = json["data"]["name"].toString();
                                   var sess = json["data"]["user_session_token"].toString();

                                   SharedPreferences pref = await SharedPreferences.getInstance();
                                   pref.setString("id", id);
                                   pref.setString("name", nam);
                                   pref.setString("user_session_token", sess);

                                   print("success");

                                   Navigator.of(context).push(
                                     MaterialPageRoute(builder: (context) => Social_Page()),
                                   );
                                   // print(id);
                                 }
                               else
                                 {
                                   Fluttertoast.showToast(
                                       msg: json["message"],
                                       toastLength: Toast.LENGTH_SHORT,
                                       gravity: ToastGravity.BOTTOM,
                                       timeInSecForIosWeb: 1,
                                       backgroundColor: Colors.red,
                                       textColor: Colors.white,
                                       fontSize: 16.0);
                                 }
                              }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: Text("LOG IN", style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),)),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                              colors: [Color.fromARGB(243, 3, 175, 26),Colors.blue])),
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: Text("CENCEL", style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),)),
                    ),
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
