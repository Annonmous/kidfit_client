import 'dart:io';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PhotoViewPage extends StatelessWidget {
  final List<dynamic> photos;
  final int index;

  static Future showGalleryView(
      BuildContext context, List photos, int selected) {
    if (Platform.isIOS) {
      return Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (ctx) => PhotoViewPage(photos: photos, index: selected),
        ),
      );
    } else {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => PhotoViewPage(photos: photos, index: selected),
        ),
      );
    }
  }

  const PhotoViewPage({
    Key? key,
    required this.photos,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            itemCount: photos.length,
            builder: (context, index) =>
                PhotoViewGalleryPageOptions.customChild(
              child: CachedNetworkImage(
                imageUrl: photos[index],
                // fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.75,
                placeholder: (context, url) => Container(
                  color: Colors.black,
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.red.shade400,
                ),
              ),
              disableGestures: false,
              tightMode: true,
              basePosition: Alignment.center,
              initialScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered,
              minScale: PhotoViewComputedScale.contained / 2,
              heroAttributes: PhotoViewHeroAttributes(tag: photos[index]),
            ),
            pageController: PageController(initialPage: index),
            enableRotation: false,
          ),
          Positioned(
            top: mediaQuery.viewPadding.top + 12,
            left: 15,
            child: SpringWidget(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
