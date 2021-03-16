import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallapaers_leo/model/wallpaper_model.dart';
import 'package:wallapaers_leo/views/image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget wallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageView(
                            imgPath: wallpaper.src.portrait,
                          )));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: wallpaper.src.portrait,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
