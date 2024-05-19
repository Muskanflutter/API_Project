import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Get_Page extends StatefulWidget {
  const Get_Page({super.key});

  @override
  State<Get_Page> createState() => _Get_PageState();
}

class _Get_PageState extends State<Get_Page> {
  Future<List>? alldata;
 Future<List> getdata()async{
    Uri url = Uri.parse("https://fakestoreapi.com/products");
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);
        return json;
        //store
      }
    else
      {
        print("Error");
        return [];
      }
    //statuscode 200 ok
    //404 api not fount
    //500 server

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata =getdata();

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get_Page"),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context,snapsots)
        {
          if(snapsots.hasData)
            {
              if(snapsots.data!.length<=0)
                {
                  return Center(
                    child: Text("No data found"),
                  );

                }
              else
                {
                  return ListView.builder(
                    itemCount: snapsots.data!.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        leading: ClipOval(
                          child: Image.network(snapsots.data![index]["image"]),
                        ),
                        title: Text(snapsots.data![index]["title"].toString()),
                        subtitle: Column(
                          children: [
                            Text(snapsots.data![index]["description"].toString()),
                            Text(snapsots.data![index]["rating"]["rate"].toString() + "    " + snapsots.data![index]["rating"]["count"].toString()),
                          ],
                        )
                      );
                    },

                  );
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
