import 'dart:convert';

import 'package:api_project/Employee/Insert_Page.dart';
import 'package:api_project/Employee/Update_Page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class View_Page extends StatefulWidget {
  const View_Page({super.key});

  @override
  State<View_Page> createState() => _View_PageState();
}

class _View_PageState extends State<View_Page> {
  Future<List>? alldata;
  Future<List> getdata() async{
    Uri url = Uri.parse("https://studiogo.tech/student/studentapi/getEmployee.php");
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);
       var data;
        if(json["status"].toString()=="true")
          {
             data = json["data"];
          //  return data;
          }
        return data;
      }
    else
    {
      print("Error");
      return[];
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>Insert_Page()),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("View_Page"),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context,snapsorts)
        {
          if(snapsorts.hasData)
            {
              if(snapsorts.data!.length<=0)
                {
                  return Center(
                    child: Text("No data found"),
                  );
                }
              else
                {
                  return ListView.builder(
                    itemCount: snapsorts.data!.length,
                      itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Insert_Page()));
                        },
                        child: ListTile(
                          title: Text(snapsorts.data![index]["eid"].toString()+ " " +snapsorts.data![index]["department"].toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: ()async{
                                Uri url = Uri.parse("https://studiogo.tech/student/studentapi/deleteEmployeeNormal.php");
                                var param = { "eid": snapsorts.data![index]["eid"].toString()};
                                var res = await http.post(url,body: param);
                                if(res.statusCode==200){
                                  var json = jsonDecode(res.body.toString());
                                  if(json["status"].toString()=="true"){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => View_Page()));
                                  }
                                  else
                                  {
                                    print(json["message"].toString());

                                  }
                                }
                              }, icon: Icon(Icons.delete)),
                              IconButton(onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Update_Page(obj: snapsorts.data![index]["eid"],)));
                              }, icon: Icon(Icons.edit)),
                            ],
                          ),
                        ),
                      );
                      });
                }
            }
          else
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        },
      ),
    );
  }
}
