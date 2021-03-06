import 'package:flutter/material.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
//import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullWallpaper extends StatefulWidget {

   final String imageurl;

  const FullWallpaper({Key? key, required this.imageurl}) : super(key: key);

  @override
  _FullWallpaperState createState() => _FullWallpaperState();
}

class _FullWallpaperState extends State<FullWallpaper> {

  Future<void>setWallpaper() async{
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    String reslut = await WallpaperManager.setWallpaperFromFile(
        file.path,location);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child : Column(
            children:[
          Expanded(
            child: Container(
              child: Image.network(widget.imageurl),
            ),
          ),
              InkWell(
                onTap: (){

                },

                child: Container(
                  height: 60,width: double.infinity,
                  color: Colors.black,
                  child: Center(
                    child: Text('Set Wallpaper',
                      style: TextStyle(fontSize: 20,color: Colors.blue) ,),
                  ),),
              )
      ],
        )),
      );
}}
