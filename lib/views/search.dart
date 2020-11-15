import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/model/wallpaper_model.dart';
import 'package:wallpaper/widgets/widget.dart';

import 'package:http/http.dart' as http;  
class Search extends StatefulWidget {

  final String searchQyiry;
  Search({this.searchQyiry});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
TextEditingController textEditingController = new TextEditingController();
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
    getSearchWallpaper(widget.searchQyiry);
    textEditingController .text=widget.searchQyiry;    
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
            Container(
                decoration: BoxDecoration(color: Color(0xfff5f8fd),
                 borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(hintText: 'search',
                    border: InputBorder.none,
                    ),
                    
                    ),),
                    GestureDetector(
                      onTap: (){
                        getSearchWallpaper(textEditingController.text);
                      },
                      child: Container(
                        child: Icon(Icons.search))),
                ],),
                
              ), SizedBox(height: 10,),
              wallpaperList(wallpapers: wallpapers, context: context),
          ],),),
        ),
        
      
    );
  }
}