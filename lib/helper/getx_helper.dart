import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GetxControllersProvider extends GetxController {
  RxString imagePath = ''.obs;
  RxString AddimagePath = ''.obs;
  RxString AddvideoPath = ''.obs;

  var defaultImagePath = 'assets/images/photo.png';
  Future getImage() async {
    final _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imagePath.value = image.path.toString();
    } else {
      imagePath.value = '';
    }
  }

  Future getFromCameraImage() async {
    final _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      imagePath.value = image.path.toString();
    } else {
      imagePath.value = '';
    }
  }

  Future getImageForAddons() async {
    final _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      AddimagePath.value = image.path.toString();
    } else {
      AddimagePath.value = '';
    }
  }

  Future getFromCameraImageForAddons() async {
    final _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      AddimagePath.value = image.path.toString();
    } else {
      AddimagePath.value = '';
    }
  }

  Future getvideo() async {
    final _picker = ImagePicker();
    final image = await _picker.pickVideo(source: ImageSource.gallery);

    if (image != null) {
      AddvideoPath.value = image.path.toString();
    } else {
      AddvideoPath.value = '';
    }
  }

  Future getvideoFromCamera() async {
    final _picker = ImagePicker();
    final image = await _picker.pickVideo(source: ImageSource.camera);

    if (image != null) {
      AddvideoPath.value = image.path.toString();
    } else {
      AddvideoPath.value = '';
    }
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }
}
