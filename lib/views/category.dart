import 'dart:convert';
import 'package:wallpaper/data/data.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:wallpaper/model/wallpaper_model.dart';
import 'package:wallpaper/widgets/widget.dart';  
class Category extends StatefulWidget {
  final String categoryName;
  Category({this.categoryName});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<wallpaperModel>  wallpapers = new List();

  getSearchWallpaper(String query) async
   {
     var response = await http.get("https://api.pexels.com/v1/search?query=$query&per_page=15&page=1", 
     headers: {
       "Authorization" : apiKey
      
     }
     ); //print(response.body.toString());
     Map<String, dynamic> jsondata = jsonDecode(response.body);
     jsondata["photos"].forEach((element){
      // print(element);
     wallpaperModel model=  new  wallpaperModel();
        model =  wallpaperModel.fromMap(element);
        wallpapers.add(model);
       });
       setState(() {
         
       });
   }
   @override
  void initState() {
    getSearchWallpaper(widget.categoryName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.white,
        title: brandName(),
        elevation: 0.0,
        ),
        body: SingleChildScrollView(
                  child: Container(child: Column(children: [
           
              SizedBox(height: 10,),
              wallpaperList(wallpapers: wallpapers, context: context),
            ])
            )
            ),);
                
      
    
  }
}