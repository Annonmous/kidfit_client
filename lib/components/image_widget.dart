import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodeoapp/components/small_loader.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? boxfit;
  const ImageWidget(
      {super.key,
      required this.imageUrl,
      this.height,
      this.width,
      this.boxfit});
  @override
  Widget build(BuildContext context) {
    return imageUrl.isEmpty
        ? Image.asset(
            'assets/images/default.jpg',
            height: height,
            width: width,
            fit: BoxFit.fill,
          )
        : CachedNetworkImage(
            imageUrl: imageUrl,
            height: height,
            width: width,
            fit: boxfit ?? BoxFit.cover,
            placeholder: (context, url) => SmallLoader(),
            // Image.asset(
            //       'assets/images/whitebg.jpeg',
            //       height: height,
            //       width: width,
            //       fit: BoxFit.fill,
            //     ),
            errorWidget: (context, url, error) => Image.asset(
                  'assets/images/default.jpg',
                  height: height,
                  width: width,
                  fit: BoxFit.fill,
                ));
  }
}
