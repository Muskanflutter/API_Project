import 'dart:convert';
import 'dart:io';

import 'package:api_project/Models/Product.dart';
import 'package:api_project/NormalProduct/Add_data.dart';
import 'package:api_project/NormalProduct/Update_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Get_data extends StatefulWidget {
  const Get_data({super.key});

  @override
  State<Get_data> createState() => _Get_dataState();
}

class _Get_dataState extends State<Get_data> {
  List<Product>? alldata;
  getdata()async
  {
    Uri url = Uri.parse("https://studiogo.tech/student/studentapi/getProducts.php");
    var res = await http.get(url);
    // var body = responce.body.toString();
    if(res.statusCode == 200)
      {
        var json = jsonDecode(res.body.toString());
if(json["status"]=="true")
  {
    setState(() {
      alldata = json["data"].map<Product>((obj) => Product.fromJson(obj)).toList();
    });
  }
else
  {
    print(json["message"]);
  }
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get_data"),
      ),
      body: (alldata == null) ? Center(child: CircularProgressIndicator(),) : (alldata!.length <= 0) ? Center(child: Text("No data found"),) :
          ListView.builder(
            itemCount: alldata!.length,
              itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Add_data()),
                  );
                },
                child: ListTile(
                  title: Text(alldata![index].pname.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async{
                          Uri url=Uri.parse("https://studiogo.tech/student/studentapi/deleteProductNormal.php");
                          var param = {"pid":alldata![index].pid.toString()};
                          var res = await http.post(url,body: param);
                          if(res.statusCode==200) {
                            var json = jsonDecode(res.body.toString());
                            if(json["status"].toString()=="true") {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Get_data()));
                            }
                            else
                            {
                              print(json["message"].toString());

                            }
                          }

                        },
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>Update_data(obj: alldata![index])),
                        );
                      }, icon: Icon(Icons.edit)),
                    ],
                  )
                ),
              );
              }),
    );
  }
}
