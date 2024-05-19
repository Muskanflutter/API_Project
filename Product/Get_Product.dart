import 'dart:convert';

import 'package:api_project/Product/Detail_Product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Get_Product extends StatefulWidget {
  const Get_Product({super.key});

  @override
  State<Get_Product> createState() => _Get_ProductState();
}

class _Get_ProductState extends State<Get_Product> {
  Future<List>? alldata;
 Future<List>? getdata()async{
    Uri url = Uri.parse("https://api.escuelajs.co/api/v1/products");
    var response = await http.get(url);
    if(response.statusCode == 200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);
        return json;
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
      appBar: AppBar(
        title: Text("Get_Product"),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context,snapshort)
          {
            if(snapshort.hasData)
              {
                if(snapshort.data!.length<=0)
                  {
                    return Center(
                      child: Text("No data found"),
                    );
                  }
                else{
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context,index){
                        var imageUrl = snapshort.data![index]["images"][0].toString();
                        if (imageUrl.startsWith('["') && imageUrl.endsWith('"]')) {
                          imageUrl = imageUrl.substring(2, imageUrl.length - 2);
                        }
                        if(imageUrl.startsWith('["') && imageUrl.endsWith('"')){
                          imageUrl = imageUrl.substring(2, imageUrl.length -1);
                        }
                        return GestureDetector(
                          onTap: (){
                            var pho = imageUrl;
                            var t=snapshort.data![index]["title"].toString();
                            var p=snapshort.data![index]["price"].toString();
                            var d=snapshort.data![index]["description"].toString();
                            var nm = snapshort.data![index]["category"]["name"].toString();
                            var img = snapshort.data![index]["category"]["image"].toString();
                            // var ctg = snapshort.data![index]["category"]["name"].toString()+ "" + snapshort.data![index]["category"]["image"].toString();

                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>Detail_Product(phot: pho,pri: p,titl: t,des: d,nam: nm,imge: img,)),
                            );
                          },
                          child: Column(
                            children: [
                              Expanded(child: Image.network(imageUrl,fit: BoxFit.cover,)),
                              Text(snapshort.data![index]["title"].toString()),
                              Text(snapshort.data![index]["price"].toString()),
                            ],
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
          }
      ),
    );
  }
}
