class Constants {
  static const double screenPadding = 10;
  static const String currency = '€';
  static var API_HOST = "";

  static final postReview = "$API_HOST/api/discover/reviews";
  static final patchOrdersAction = "$API_HOST/api/order/restaurantOrdersAction";
  static final getMyOrder = "$API_HOST/api/order/userOrders";
  static final getReceivedOrder = "$API_HOST/api/order/restaurantOrders";
  static final postAuth = "$API_HOST/api/auth/join";
  static final postUpdateProfile = "$API_HOST/api/profile/updateRestaurantInfo";
  static final postOrderProceed = "$API_HOST/api/order/postOrder";
  static final getOrderSummary = "$API_HOST/api/order/orderSummary";

  static final getOrderDelivery = "$API_HOST/api/order/getDeliveryProviders";
  static final getPrdouctNutrients = "$API_HOST/api/discover/nutrients";
  static final postOrderQuantity = "$API_HOST/api/order/toggleOrderQuantity";

  static final productComment = "$API_HOST/api/discover/comments";
  static final getPrdouctReview = "$API_HOST/api/discover/reviews";
  static final getReels = "$API_HOST/api/discover/videos";
  static final UploadReels = "$API_HOST/api/discover/postVideos";
  static final gettags = "$API_HOST/api/discover/tags";

  static final getrestaurantProfileData =
      "$API_HOST/api/profile/restaurantProfileById";
  static final getrestaurantProfile = "$API_HOST/api/profile/restaurantProfile";
  static final getAllergens = "$API_HOST/api/discover/allergens";
  static final restaurantProductsByVideo =
      "$API_HOST/api/profile/restaurantProductsByVideo";
  static final exploreProduct = "$API_HOST/api/explore/products";
  static final PopularProduct = "$API_HOST/api/explore/getPopularProducts";
  static final RecommendedProduct =
      "$API_HOST/api/explore/getRecommendedProducts";
  static final getaddons = "$API_HOST/api/order/addons";
  static final Addaddons = "$API_HOST/api/order/addToCart";
  static final updateUserDetails = "$API_HOST/api/profile/updateUserDetails";
  static final updateRestaurantInfo =
      "$API_HOST/api/profile/updateRestaurantInfo";

  static final getDeliveryProviders =
      "$API_HOST/api/order/getDeliveryProviders";
  static final getrestaurantEditProfileData =
      "$API_HOST/api/profile/restaurantInfo";

  static final toggleyummy =
      "$API_HOST/api/discover/toggleyummy";
}
