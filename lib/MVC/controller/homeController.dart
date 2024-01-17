import 'package:foodeoapp/MVC/model/CartModel.dart';
import 'package:foodeoapp/MVC/model/ExploreModel.dart';
import 'package:foodeoapp/MVC/model/product_model.dart';
import 'package:foodeoapp/data/mockData.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;

  RxList<ProductModel> ProductList = <ProductModel>[].obs;
  RxList<CartModel> CartList = <CartModel>[].obs;
  final SelectedKidId = 0.obs;
  final SelectedKidName = ''.obs;
  var Isloading = false.obs;
  var RecommendedProductIsloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPopulerProductData();
  }

  getPopulerProductData() async {
    try {
      Isloading.value = true;
      // final PopularData = await ExploreAPI.getPopulerProductData();

      ProductList.value = MockData.dummyProducts;

      print('ProductList: ${ProductList.length}');
      Isloading.value = false;
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

  ///action 1 for add
  ///action 0 for remove
  addAndRemoveCart(CartModel cartData, int action) async {
    try {
      if (action == 1) {
        CartList.add(cartData);
      } else {
        CartList.remove(cartData);
      }
      print('CartList: ${CartList.length}');
    } catch (e) {
      Isloading.value = false;
      print('error AddKids view model:$e');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
