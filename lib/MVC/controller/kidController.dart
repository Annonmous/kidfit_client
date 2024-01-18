import 'package:foodeoapp/MVC/model/ExploreModel.dart';
import 'package:foodeoapp/MVC/model/kidsModel.dart';
import 'package:foodeoapp/MVC/model/product_model.dart';
import 'package:foodeoapp/data/mockData.dart';
import 'package:get/get.dart';

class KidsController extends GetxController {
  final selectedIndex = 0.obs;

  RxList<KidsModel> KidsList = <KidsModel>[].obs;

  var Isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllKids();
  }

  getAllKids() async {
    try {
      Isloading.value = true;
      // final PopularData = await ExploreAPI.getPopulerProductData();

      // KidsList.value = MockData.dummyKidsData;

      // print('KidsList: ${KidsList.length}');
      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('error getPopulerProductData view model:$e');
    }
  }

  AddKids(KidsModel kidData) async {
    try {
      // final PopularData = await ExploreAPI.getPopulerProductData();

      KidsList.add(kidData);
      print('KidsList: ${KidsList.length}');
    } catch (e) {
      Isloading.value = false;
      print('error getPopulerProductData view model:$e');
    }
  }
  // getSearchProduct(String search) async {
  //   try {
  //     RecommendedProductIsloading.value = true;
  //     final SearchData = await ExploreAPI.getSearchProduct(search);

  //     SaerchList.value = SearchData;

  //     print('SaerchList: ${SaerchList.length}');
  //     RecommendedProductIsloading.value = false;
  //   } catch (e) {
  //     RecommendedProductIsloading.value = false;
  //     print('error getRecommendedProductDataByTag view model:$e');
  //   }
  // }

  @override
  void onClose() {
    super.onClose();
  }
}
