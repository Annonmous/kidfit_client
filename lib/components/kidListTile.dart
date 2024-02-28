import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodeoapp/MVC/model/kidsModel.dart';
import 'package:foodeoapp/components/image_widget.dart';
import 'package:foodeoapp/components/spring_widget.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:qr_flutter/qr_flutter.dart';

class KidListTile extends StatelessWidget {
  const KidListTile({
    super.key,
    required this.KidsData,
  });

  final KidsModel KidsData;

  @override
  String generateQRData() {
    // Replace this with your actual KidsModel data
    Map<String, dynamic> kidsData = {
      'id': KidsData.id,
      'name': KidsData.name,
      'parentId': KidsData.parentId,
      'schoolId': KidsData.schoolId,

      'createDate': DateTime.now().toString(),
      'updateDate': DateTime.now().toString(),
    };

    return kidsData.toString();
  }

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(179, 0, 0, 0).withOpacity(0.1),
              blurRadius: 20.0,
              spreadRadius: 1,
              offset: Offset(2, 8),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.sp),
          child: ListTile(
            // leading: CircleAvatar(
            //   backgroundColor: Colors.white,
            //   radius: 21.sp,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(110),
            //     child: ImageWidget(
            //         height: 80.sp,
            //         width: 100,
            //         imageUrl:
            //             'https://a.storyblok.com/f/191576/1200x800/faa88c639f/round_profil_picture_before_.webp'),
            //   ),
            // ),
            title: Text(
              KidsData.name,
              style: TextStyle(
                  color: themecontroller.textcolor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ),
            // subtitle: Text(
            //   'Student of ${KidsData.}',
            //   style: TextStyle(
            //     color: themecontroller.textcolor.withOpacity(0.7),
            //     fontSize: 10.sp,
            //   ),
            // ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              // Icon(Icons.edit, size: 20.sp),
              SizedBox(
                width: 20.sp,
              ),
              SpringWidget(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(child:
                          GetBuilder<ThemeHelper>(builder: (themecontroller) {
                        return Container(
                          height: 300.sp,
                          child: Column(children: [
                            SizedBox(
                              height: 30.sp,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: QrImageView(
                                  data: generateQRData(),
                                  size: 150.sp,
                                ),
                              ),
                            ),
                            Text(
                              'Student Name: ${KidsData.name}',
                              style: TextStyle(
                                  color: themecontroller.colorPrimary,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 20.sp,),
                            Text(
                              'Class: ${KidsData.classNo}',
                              style: TextStyle(
                                  color: themecontroller.colorPrimary,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            // Text(
                            //   'Student of ${KidsData.schoolName}',
                            //   style: TextStyle(
                            //     color:
                            //         themecontroller.textcolor.withOpacity(0.7),
                            //     fontSize: 10.sp,
                            //   ),
                            // ),
                          ]),
                        );
                      }));
                    },
                  );
                },
                child: Icon(
                  Icons.qr_code_rounded,
                  size: 20.sp,
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
