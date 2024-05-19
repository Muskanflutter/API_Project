import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Detail_Product extends StatefulWidget {
  var phot;
  var pri;
  var titl;
  var des;
  var nam;
  var imge;
  Detail_Product({super.key,this.phot,this.pri,this.titl,this.des,this.nam,this.imge});

  @override
  State<Detail_Product> createState() => _Detail_ProductState();
}

class _Detail_ProductState extends State<Detail_Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail_Product"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child:  Image.network(widget.phot,fit: BoxFit.cover,),
            ),
            Text(widget.pri,style: TextStyle(fontSize: 30),),
            Text(widget.titl,style: TextStyle(fontSize: 20),),
            Text(widget.des),
            Center(
              child: RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child:  Image.network(widget.imge),
            ),
            Text(widget.nam,style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}
