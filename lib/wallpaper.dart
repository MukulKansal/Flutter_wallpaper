import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wallpaper_app/fullWallpaper.dart';

class Wallpaper extends StatefulWidget {

  const Wallpaper({Key? key}) : super(key: key);

  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {

  List images = [];
  int page = 1;
  @override

  void initState(){
    super.initState();
    fetchapi();
  }

  fetchapi() async{
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers:{'Authorization':'563492ad6f91700001000001509ad51364b248c0a176f53851c4375e'
        }).then((value) {
          Map result = jsonDecode(value.body);
          setState(() {
            images = result['photos'];
          });
          print(images[0]);
    });
  }

  loadMore() async{

    setState(() {
      page = page+1;
    });
    String url =
        'https://api.pexels.com/v1/curated?per_page=80&page='+page.toString();
    await http.get(Uri.parse(url),
        headers:{'Authorization':'563492ad6f91700001000001509ad51364b248c0a176f53851c4375e'
        }).then((value) {
          Map result = jsonDecode(value.body);
          setState(() {
            images.addAll(result['photos']);
          });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Container(
            child: GridView.builder(itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 2,
                    childAspectRatio: 2/3, mainAxisSpacing: 2),
                itemBuilder: (context,index){
                  return InkWell(

                    onTap: (){
                      Navigator.push(context, MaterialPageRoute
                        (builder: (context)=>FullWallpaper(
                        imageurl: images[index]['src']['large2x'],
                      )));
                    },

                    child: Container(color: Colors.white,
                    child: Image.network(images[index]['src']
                    ['tiny'],fit: BoxFit.cover,
                    ),),
                  );
                }),
          )
          ),
          InkWell(
            onTap: (){
              loadMore();
            },

            child: Container(
              height: 60,width: double.infinity,
              color: Colors.black,
              child: Center(
                child: Text('Load More',
                  style: TextStyle(fontSize: 20,color: Colors.blue) ,),
              ),),
          )
        ],
      ),
    );
  }
}
