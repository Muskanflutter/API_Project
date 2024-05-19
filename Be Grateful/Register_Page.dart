import 'dart:convert';

import 'package:api_project/Be%20Grateful/Login_Page.dart';
import 'package:api_project/Be%20Grateful/Login_Signup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Register_Page extends StatefulWidget {
  const Register_Page({super.key});

  @override
  State<Register_Page> createState() => _Register_Page();
}

class _Register_Page extends State<Register_Page> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Stack(
       children: [
         Container(
           decoration: BoxDecoration(
             image: DecorationImage(image: AssetImage("Img/img_2.png"),
               fit: BoxFit.cover,),
           ),
         ),
         Center(
           child: SingleChildScrollView(
             child: Container(
               height: 600,
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                 color: Colors.black54,
                 border: Border.all(color: Colors.black),
                 borderRadius: BorderRadius.circular(30),
               ),
               child: Column(
                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Text("Welcome",style: TextStyle(fontSize: 40,color: Colors.white,),),
                   Text("Sign up to Continue"),
                   SizedBox(height: 20,),
                   Padding(
                     padding: const EdgeInsets.only(right: 210),
                     child: Text("Register",style: TextStyle(color: Colors.purple.shade300,fontSize: 30),),
                   ),
                   SizedBox(height: 20,),
                   TextField(
                     controller: name,
                     decoration: InputDecoration(
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                       label: Text("Name:",style: TextStyle(color: Colors.white),),
                     ),
                     keyboardType: TextInputType.name,
                   ),
                   SizedBox(height: 10,),
                   TextField(
                     controller: email,
                     decoration: InputDecoration(
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                       label: Text("Email:",style: TextStyle(color: Colors.white),),
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
                       label: Text("Password:",style: TextStyle(color: Colors.white),),
                     ),
                     keyboardType: TextInputType.visiblePassword,
                     obscureText: true,
                   ),
                   SizedBox(height: 10,),
                   TextField(
                     controller: confirmpassword,
                     decoration: InputDecoration(
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                       label: Text("Confirm Password:",style: TextStyle(color: Colors.white),),
                     ),
                     keyboardType: TextInputType.visiblePassword,
                     obscureText: true,
                   ),
                   SizedBox(height: 40,),
                   Container(
                     height: 50,
                     width: 150,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(50),
                         gradient: LinearGradient(
                             colors: [Color.fromARGB(243, 3, 175, 26),Colors.blue])),
                     child: ElevatedButton(
                         onPressed: ()async{
                           var nm = name.text.toString();
                           var em = email.text.toString();
                           var pass = password.text.toString();
                           var con = confirmpassword.text.toString();

                           Uri url = Uri.parse("https://begratefulapp.ca/api/register");
                           var param = {
                               "name": nm,
                               "email": em,
                               "password": pass,
                               "confirm_password": con,
                           };
                           var res = await http.post(url,body: param);
                           if(res.statusCode==200){
                             var json = jsonDecode(res.body.toString());
                             if(json["result"] == "success")
                               {
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login_Page()));
                                 Fluttertoast.showToast(
                                     msg: json["message"],
                                     toastLength: Toast.LENGTH_SHORT,
                                     gravity: ToastGravity.BOTTOM,
                                     timeInSecForIosWeb: 1,
                                     backgroundColor: Colors.red,
                                     textColor: Colors.white,
                                     fontSize: 16.0);
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
                           else
                           {
                             print("Invalid api data");
                           }

                         },
                         style: ElevatedButton.styleFrom(
                             backgroundColor: Colors.transparent,
                             shadowColor: Colors.transparent),
                         child: Text("REGISTER", style: TextStyle(
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
