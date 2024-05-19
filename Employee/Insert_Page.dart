import 'dart:convert';

import 'package:api_project/Employee/View_Page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Insert_Page extends StatefulWidget {
  const Insert_Page({super.key});

  @override
  State<Insert_Page> createState() => _Insert_PageState();
}

class _Insert_PageState extends State<Insert_Page> {
  TextEditingController ename = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController department = TextEditingController();
  var gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert_Page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          TextField(
            controller: ename,
            decoration: InputDecoration(
              labelText: "Ename:",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 10,),
          TextField(
            controller: salary,
            decoration: InputDecoration(
              labelText: "Salary:",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 10,),
          TextField(
            controller: department,
            decoration: InputDecoration(
              labelText: "Department:",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
          RadioListTile(
            title: Text("Male"),
              value: "male",
              groupValue: gender,
              onChanged: (val){
                setState(() {
                  gender = val;
                });
              }),
          RadioListTile(
            title: Text("Female"),
              value: "female",
              groupValue: gender,
              onChanged: (val){
                setState(() {
                  gender = val;
                });
              }),
          ElevatedButton(onPressed: ()async{

            var enm = ename.text.toString();
            var sell = salary.text.toString();
            var dep = department.text.toString();
            var gdr = gender.toString();

            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>View_Page()));

            Uri url = Uri.parse("https://studiogo.tech/student/studentapi/insertEmployeeNormal.php");
            var param = {
              "ename": enm,
              "salary": sell,
              "department": dep,
              "gender": gdr,
            };
            var responce = await http.post(url,body: param);
            if(responce.statusCode==200)
              {
                var json = jsonDecode(responce.body.toString());
                if(json["status"].toString() == "true")
                  {
                    // var id = json["data"]["eid"].toString();
                    print(json["message"].toString());
                  }
                else
                  {
                    print(json["message"].toString());
                  }
              }
            else
              {
                print("invalid api data");
              }

          }, child: Text("Submit")),
        ],
      ),
    );
  }
}
