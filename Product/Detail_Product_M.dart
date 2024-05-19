import 'package:api_project/Models/FakeProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Detail_Product_M extends StatefulWidget {
  //const Detail_Product_M({super.key});
  FakeProduct obj;
  Detail_Product_M({required this.obj});
  @override
  State<Detail_Product_M> createState() => _Detail_Product_MState();
}

class _Detail_Product_MState extends State<Detail_Product_M> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.obj.images![0].toString()),
            SizedBox(height: 10,),
            Text("Best Seller",style: TextStyle(color: Colors.green,backgroundColor: Colors.grey.shade300),),
            SizedBox(height: 10,),
            Text(widget.obj.title.toString(),style: TextStyle(fontSize: 20),),
            Text(widget.obj.price.toString(),style: TextStyle(fontSize: 30,color: Colors.green),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){
                  print("save");
                }, icon: Icon(Icons.save_alt)),
                IconButton(onPressed: (){
                  print("share");
                }, icon: Icon(Icons.share)),
              ],
            ),
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
                height: 150,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(widget.obj.description.toString())),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(widget.obj.category!.name.toString(),style: TextStyle(fontSize: 20,color: Colors.black87),),
                SizedBox(width: 150,),
               TextButton(onPressed: (){}, child: Text("See All")),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 20,),
                Image.network(widget.obj.category!.image.toString(),height: 150,),
                SizedBox(width: 20,),
                Image.network(widget.obj.category!.image.toString(),height: 150,),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 150,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey.shade300),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(10), shadowColor: Color(20)),
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 150,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey.shade300),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(10), shadowColor: Color(20)),
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
