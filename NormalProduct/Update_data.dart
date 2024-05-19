import 'dart:convert';

import 'package:api_project/Models/Product.dart';
import 'package:api_project/NormalProduct/Get_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Update_data extends StatefulWidget {
  Product obj;
    Update_data({super.key, required this.obj});

  @override
  State<Update_data> createState() => _Update_dataState();
}

class _Update_dataState extends State<Update_data> {

  getSingledata()async{

    _nm.text = widget.obj.pname.toString();
    _pr.text = widget.obj.price.toString();
    _qty.text = widget.obj.qty.toString();

       }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSingledata();
  }
  TextEditingController _nm = TextEditingController();
  TextEditingController _pr = TextEditingController();
  TextEditingController _qty = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update_data"),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          TextField(
            controller: _nm,
            decoration: InputDecoration(
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
          ElevatedButton(onPressed: ()async{
            var p_nm= _nm.text.toString();
            var p_pr= _pr.text.toString();
            var p_qty= _qty.text.toString();

            Uri url = Uri.parse("https://studiogo.tech/student/studentapi/updateProductNormal.php");
            var param = {
              "pname":p_nm,
              "price" : p_pr,
              "qty":p_qty,
              "pid":widget.obj.pid,
            };
            var res = await http.post(url,body: param);
            if(res.statusCode==200)
            {
              var json=jsonDecode(res.body.toString());
              if(json["status"].toString()=="true")
              {
                print(json["message"].toString());
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Get_data()),
                );
                //nevigate
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


          }, child: Text("Update")),
        ],
      ),
    );
  }
}
