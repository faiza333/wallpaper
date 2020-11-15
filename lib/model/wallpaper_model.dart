

class wallpaperModel
{
  String photographer;
  String photographer_url;
  int photographer_id;
  Srcmodel src;
wallpaperModel({this.photographer,this.photographer_id,this.photographer_url,this.src});
factory wallpaperModel.fromMap(Map<String, dynamic> jsondata)
{
  return wallpaperModel(
  src: Srcmodel.fromMap(jsondata["src"]),
  photographer: jsondata["photographer"],
  photographer_id: jsondata["photographer_id"],
  photographer_url: jsondata[" photographer_url"],
  
  );
}



}

class Srcmodel {

  String original;
  String small;
  String portrait;
Srcmodel({this.original,this.portrait,this.small});
factory Srcmodel.fromMap(Map<String , dynamic> jsondata) 
{
  return Srcmodel(
  original: jsondata["original"],
  small: jsondata["small"],
  portrait: jsondata["portrait"],

  );
}
}