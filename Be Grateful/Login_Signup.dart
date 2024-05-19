import 'package:api_project/Be%20Grateful/Login_Page.dart';
import 'package:api_project/Be%20Grateful/Register_Page.dart';
import 'package:flutter/material.dart';

class Login_Signup extends StatefulWidget {
  const Login_Signup({super.key});

  @override
  State<Login_Signup> createState() => _Login_SignupState();
}

class _Login_SignupState extends State<Login_Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("Img/img_2.png"),
            fit: BoxFit.cover,),
        ),
        child: Center(
          child: Stack(
            children: [
              Container(
                height: 550,
                width: 330,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text("Welcome to the",style: TextStyle(fontSize: 30,color: Colors.white),),
                    SizedBox(height: 10,),
                    Text("application",style: TextStyle(fontSize: 30,color: Colors.white),),
                    SizedBox(height: 50,),
                    Image.asset("Img/img_1.png",fit: BoxFit.none,height: 190,),
                    SizedBox(height: 50,),
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                              colors: [Color.fromARGB(243, 3, 175, 26),Colors.blue])),
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login_Page()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: Text("LOG IN",style: TextStyle(
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register_Page()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: Text("SIGN UP", style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
