import 'package:flutter/material.dart';
import 'package:foodeoapp/components/photo_view_page.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'image_widget.dart';

class BannersSliderView extends StatelessWidget {
  final List<String> imagelist;

  BannersSliderView({
    Key? key,
    required this.imagelist,
  }) : super(key: key);
  final ValueNotifier selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
      builder: (themeController) => AnnotatedRegion(
        value: themeController.systemUiOverlayStyleForwhite,
        child: Container(
          height: 350,
          decoration: BoxDecoration(
            // color: Colors.yellow,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(
                onPageChanged: (index) {
                  selectedIndex.value = index;
                },
                itemCount: imagelist.length,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: GestureDetector(
                    onTap: () {
                      PhotoViewPage.showGalleryView(
                          context, imagelist, index);
                    },
                    child: ImageWidget(
                      imageUrl: imagelist[index],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ValueListenableBuilder(
                    valueListenable: selectedIndex,
                    builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        height: 10,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: ((context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: CircleAvatar(
                                  backgroundColor: value == index
                                      ? Colors.amber
                                      : Colors.white.withOpacity(0.3),
                                  maxRadius: 5,
                                ),
                              )),
                          itemCount: imagelist.length,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BannerSliderViewTwo extends StatelessWidget {
  BannerSliderViewTwo({super.key, required this.imagelist, this.horizontal});

  final List<String> imagelist;
  final double? horizontal;

  final ValueNotifier selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade800.withOpacity(0.25),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(1, 1)),
        ],
      ),
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (index) {
              selectedIndex.value = index;
            },
            itemCount: imagelist.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontal ?? 8, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: GestureDetector(
                  onTap: () {
                    PhotoViewPage.showGalleryView(context, imagelist, index);
                  },
                  child: ImageWidget(
                    imageUrl: imagelist[index],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ValueListenableBuilder(
                valueListenable: selectedIndex,
                builder: (context, value, child) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 10,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: ((context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CircleAvatar(
                              backgroundColor: value == index
                                  ? Colors.amber
                                  : Colors.black45,
                              maxRadius: 5,
                            ),
                          )),
                      itemCount: imagelist.length,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
