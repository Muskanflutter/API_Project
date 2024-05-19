import 'dart:convert';

import 'package:api_project/Models/FakeProduct.dart';
import 'package:api_project/Product/Detail_Product.dart';
import 'package:api_project/Product/Detail_Product_M.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Get_Product_M extends StatefulWidget {
  const Get_Product_M({super.key});

  @override
  State<Get_Product_M> createState() => _Get_Product_MState();
}

class _Get_Product_MState extends State<Get_Product_M> {
  List<FakeProduct>? alldata;
  getdata() async
  {
    Uri url = Uri.parse("https://api.escuelajs.co/api/v1/products");
    var res = await http.get(url);
    if(res.statusCode==200)
      {
        var json = jsonDecode(res.body.toString());
        //loop
        //sigle obj
        //json convert
        //store
        setState(() {
          alldata = json.map<FakeProduct>((obj)=>FakeProduct.fromJson(obj)).toList();
        });
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
      appBar: AppBar(title: Text("GetDetails"),),
      body: (alldata==null) ? Center(child: CircularProgressIndicator(),) : (alldata!.length <= 0 ) ? Center(child: Text("No data found"),) :
      ListView.builder(
          itemCount: alldata!.length,
          itemBuilder: (context,index)
      {
         return GestureDetector(
           onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Detail_Product_M(obj : alldata![index])));
           },
           child:Column(
             children: [
               Image.network(alldata![index].images![0].toString()),
               Text(alldata![index].price.toString()),
               Text(alldata![index].title.toString()),
               // Text(alldata![index].category!.name.toString()),
             ],
           ),
         );
      }),

    );
  }
}
