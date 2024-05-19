import 'dart:convert';

import 'package:api_project/Employee/View_Page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Update_Page extends StatefulWidget {
  var obj;
   Update_Page({super.key,required this.obj});

  @override
  State<Update_Page> createState() => _Update_PageState();
}

class _Update_PageState extends State<Update_Page> {
  getSingledata()async{
    print(widget.obj);
    Uri url  = Uri.parse("https://studiogo.tech/student/studentapi/getSingleEmployee.php");
    var param = { "eid": widget.obj.toString()};
    var res = await http.post(url,body: param);
    if(res.statusCode==200)
      {
        var json = jsonDecode(res.body.toString());
        print(json["data"]);
        setState(() {
          ename.text = json["data"]["ename"].toString();
          salary.text =json["data"]["salary"].toString();
          department.text = json["data"]["department"].toString();
          gender = json["data"]["gender"].toString();
        });
      }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSingledata();
  }
  TextEditingController ename = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController department = TextEditingController();
  var gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update_Page"),),
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
            Uri url = Uri.parse("https://studiogo.tech/student/studentapi/updateEmployeeNormal.php");
            var param = {
              "ename": enm,
              "salary": sell,
              "department": dep,
              "gender": gdr,
              "eid": widget.obj.toString(),
            };
            var responce = await http.post(url,body: param);
            if(responce.statusCode==200)
            {
              var json=jsonDecode(responce.body.toString());
              if(json["status"].toString()=="true")
              {
                print(json["message"].toString());
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => View_Page()),
                );
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
