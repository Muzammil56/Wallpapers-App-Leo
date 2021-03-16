import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallapaers_leo/data/data.dart';
import 'package:wallapaers_leo/model/wallpaper_model.dart';
import 'package:wallapaers_leo/widgets/widget.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallpaperModel> wallpapers = List();

  TextEditingController searchController = TextEditingController();
  getSearchWallpaper(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=80&page=1",
        headers: {"Authorization": apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpaper(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
            'Wallpapers Leo',
            style: TextStyle(fontFamily: 'FiraSans')
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'search wallpaper',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.grey,
                          borderRadius: BorderRadius.circular(200.0),
                          customBorder: StadiumBorder(),
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Search(
                                        searchQuery: searchController.text,
                                      )));
                            });
                          },
                          child: Container(child: Icon(Icons.search),height: 40.0, width: 40.0,),
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              wallpapersList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),

    );
  }
}