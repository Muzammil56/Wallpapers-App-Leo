import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:wallapaers_leo/data/data.dart';
import 'package:wallapaers_leo/model/categories_model.dart';
import 'package:wallapaers_leo/model/wallpaper_model.dart';
import 'package:wallapaers_leo/views/category.dart';
import 'package:wallapaers_leo/views/search.dart';
import 'package:wallapaers_leo/widgets/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = List();
  List<WallpaperModel> wallpapers = List();
  TextEditingController searchController = TextEditingController();

  getTrendingWallpaper() async {
    var response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=80&page=1",
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
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Wallpapers Leo',
            style: TextStyle(fontFamily: 'FiraSans')
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10.0),
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
              SizedBox(height: 8,),
              wallpapersList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  'Categories',
                  style:
                  GoogleFonts.firaSans(fontSize: 40.0, color: Colors.white,),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/pic.jpg"), fit: BoxFit.cover),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: categories == null ? 0 : categories.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return CategroiesTile(
                      title: categories[index].categoriesName);
                }),
          ],

      ),
      ),
    );
  }
}

class CategroiesTile extends StatelessWidget {
  final title;

  CategroiesTile({@required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Category(
                  categoryName: title.toLowerCase(),
                )));
      },
      child: Column(
        children: [
          Container(
            height: 50.0,
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.yanoneKaffeesatz(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}