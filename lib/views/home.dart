import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/model/category_model.dart';
import 'package:wallpaper/model/wallpaper_model.dart';
import 'package:wallpaper/views/category.dart';
import 'package:wallpaper/views/search.dart';
import 'package:wallpaper/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
//i make a list of model so i can get the data by it
   List<CategorieModel> categories = new List();
   List<wallpaperModel>  wallpapers = new List();
   TextEditingController textEditingController = new TextEditingController();

   getTrendingWallpaper() async
   {
     var response = await http.get("https://api.pexels.com/v1/curated?per_page=15&page=1", 
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
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.white,
        title: brandName(),
        //centerTitle: true,
//all appbar have elevation so we will despose it,
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
                Expanded(child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(hintText: 'search',
                  border: InputBorder.none,
                  ),
                  
                  ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Search(
                          searchQyiry: textEditingController.text,
                        )
                      ));
                    },
                    child: Container(
                      child: Icon(Icons.search))),
              ],),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              height: MediaQuery.of(context).size.height * .12,
              child: ListView.builder(
//i use scrolldirection i should give a height for the list
//so i wrapp it into container
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                 return CategoriesList(
                    title: categories[index].categorieName,
                    imgUrl: categories[index].imgUrl,
                    );
                }, 
                ),
            ),
            SizedBox(height: 10,),
            wallpaperList(wallpapers: wallpapers, context: context),
          ],),),
        ),

      
    );
  }
}

class CategoriesList extends StatelessWidget {
  final String imgUrl, title;
  CategoriesList({@required this.imgUrl,@required this.title}); 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>   Category(
          categoryName: title.toLowerCase(),
        )));
      },
          child: Container(
        
        margin: EdgeInsets.only(right: 9),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imgUrl,fit: BoxFit.cover,height: 70, width: 100,)),
          Container(
            decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(12),),
            height: 70, width: 100,
            alignment: Alignment.center,
            child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),)
        ],),
        
      ),
    );
  }
}