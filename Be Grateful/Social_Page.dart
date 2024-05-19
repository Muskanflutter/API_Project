import 'dart:convert';

import 'package:api_project/Be%20Grateful/SocialModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Social_Page extends StatefulWidget {
  const Social_Page({super.key});

  @override
  State<Social_Page> createState() => _Social_PageState();
}

class _Social_PageState extends State<Social_Page> {
  var id, nm, token;
   List<SocialModel>? alldata;

  @override
  void initState() {
    super.initState();
      getdata();

  }

 getdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      nm = pref.getString("name");
      token = pref.getString("user_session_token");
    });

    Uri url = Uri.parse("https://begratefulapp.ca/api/social-community");
    var param = {
      "user_id": id,
      "page": "1"
    };
    var body = jsonEncode(param);
    var header = {
      "user_session_token": token.toString(),
      "Content-Type": "application/json"
    };

    var response = await http.post(url, body: body, headers: header);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body.toString());
      print(json["data"].toString());
setState(() {
  alldata = json["data"].map<SocialModel>((obj)=>SocialModel.fromJson(obj)).toList();
});
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (alldata==null)?Center(child: CircularProgressIndicator(),):(alldata!.length<=0)?Center(child: Text("no data found"),) :
          ListView.builder(
            itemCount: alldata!.length,
              itemBuilder: (context,index)
              {
                return ListTile(
                  title: Text(alldata![index].id.toString()),
                  subtitle: Text(alldata![index].userName.toString()),
                );
              }),
    );
  }
}
