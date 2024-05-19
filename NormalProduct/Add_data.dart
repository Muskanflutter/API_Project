import 'dart:convert';

import 'package:api_project/Models/Product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Add_data extends StatefulWidget {
   const Add_data({super.key});

  @override
  State<Add_data> createState() => _Add_dataState();
}

class _Add_dataState extends State<Add_data> {
  TextEditingController _nm = TextEditingController();
  TextEditingController _pr = TextEditingController();
  TextEditingController _qty = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add_data"),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          TextField(
            controller: _nm,
            decoration: InputDecoration(
              labelText: "Pname:",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 10,),
          TextField(
            controller: _pr,
            decoration: InputDecoration(
              labelText: "Pprice:",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 10,),
          TextField(
            controller: _qty,
            decoration: InputDecoration(
              labelText: "Qintity:",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
          ElevatedButton(onPressed: () async{
            var p_nm= _nm.text.toString();
            var p_pr= _pr.text.toString();
            var p_qty= _qty.text.toString();
            
            Uri url = Uri.parse("https://studiogo.tech/student/studentapi/insertProductNormal.php");
            var param = {
              "pname":p_nm,
              "price" : p_pr,
              "qty":p_qty,
            };
            var res = await http.post(url,body: param);
            if(res.statusCode==200)
              {
                var json=jsonDecode(res.body.toString());
                if(json["status"].toString()=="true")
                  {
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
            
            
          }, child: Text("Insert")),
        ],
      ),
    );
  }
}
