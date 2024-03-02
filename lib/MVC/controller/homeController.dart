import 'package:flutter/material.dart';
import 'package:foodeoapp/MVC/model/CartModel.dart';
import 'package:foodeoapp/MVC/model/ExploreModel.dart';
import 'package:foodeoapp/MVC/model/kidsModel.dart';
import 'package:foodeoapp/MVC/model/product_model.dart';
import 'package:foodeoapp/components/BrowserScreen.dart';
import 'package:foodeoapp/constant/navigation.dart';
import 'package:foodeoapp/data/mockData.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:foodeoapp/services/app_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;

  RxList<ProductModel> ProductList = <ProductModel>[].obs;
  RxList<SchoolModel> schoolList = <SchoolModel>[].obs;
  RxList<KidsModel> ChildList = <KidsModel>[].obs;
  RxList<CartModel> CartList = <CartModel>[].obs;
  final SelectedKidId = 0.obs;
  final SelectedKidName = ''.obs;
  var Isloading = false.obs;
  var IsProductloading = false.obs;
  var RecommendedProductIsloading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  getAllProductData(int school_id) async {
    try {
      IsProductloading.value = true;
      final DataList = await AppService.getInstance.getAllProduct(school_id);
      // ProductList.value = MockData.dummyProducts;
      ProductList.value = DataList;
      print('ProductList: ${ProductList.length}');
      IsProductloading.value = false;
    } catch (e) {
      IsProductloading.value = false;
      print('error getPopulerProductData view model:$e');
    }
  }

  getAllSchools() async {
    try {
      Isloading.value = true;
      final DataList = await AppService.getInstance.getAllSchools();
      // ProductList.value = MockData.dummyProducts;
      schoolList.value = DataList;
      print('getAllSchools: ${schoolList.length}');
      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('error getPopulerProductData view model:$e');
    }
  }

  getAllChildrenByParentId() async {
    try {
      Isloading.value = true;
      final DataList = await AppService.getInstance.getAllChildrenByParentId();
      // ProductList.value = MockData.dummyProducts;
      ChildList.value = DataList;
      print('ProductList: ${ProductList.length}');
      Isloading.value = false;
    } catch (e) {
      Isloading.value = false;
      print('error getPopulerProductData view model:$e');
    }
  }

  AddProduct(BuildContext context, ProductModel ProductData) async {
    try {
      final DataList =
          await AppService.getInstance.addProduct(context, ProductData);
      getAllProductData(int.parse(DataStroge.currentUserId.value));
    } catch (e) {
      Isloading.value = false;
      print('error getPopulerProductData view model:$e');
    }
  }

  CheckoutCart(int kidId, int parentId, int schoolId, List<CartModel> cartData,
      BuildContext context) async {
    try {
      print('kidId: ${kidId}');
      print('parentId: ${parentId}');
      print('schoolId: ${schoolId}');
      print('CartList: ${cartData.length}');
      final Url = await AppService.getInstance
          .checkoutCart(kidId, parentId, schoolId, CartList, context);
      CartList.removeWhere((e) => e.kidId == kidId);
      Navigation.getInstance.screenNavigation(context, BrowserScreen(url: Url));
    } catch (e) {
      print('error CheckoutCart HomeController:$e');
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
      print('error addAndRemoveCart HomeController:$e');
    }
  }

  @override
  void onClose() {
    super.onClose();
    ProductList.clear();
  }
}
