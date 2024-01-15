class ExploreModel {
  final int productId;
  final String productName;
  final String productDetails;
  final String productPrice;
  final String productImage;
  final String reviewsCount;
  final String ratingsAverage;
  final String deliveryRadius;
  final String restaurantImage;
  final String deliveryCharges;

  ExploreModel({
    required this.productId,
    required this.productName,
    required this.productDetails,
    required this.productPrice,
    required this.productImage,
    required this.reviewsCount,
    required this.ratingsAverage,
    required this.deliveryRadius,
    required this.restaurantImage,
    required this.deliveryCharges,
  });

  factory ExploreModel.fromJson(Map<String, dynamic> json) {
    return ExploreModel(
      productId: json['product_id'],
      productName: json['product_name'],
      productDetails: json['product_details'],
      productPrice: json['product_price'].toString(),
      productImage: json['product_image'],
      reviewsCount: json['reviews_count'] == null
          ? '0.0'
          : json['reviews_count'].toString(),
      ratingsAverage: json['ratings_average'] == null
          ? '0.0'
          : json['ratings_average'].toString(),
      deliveryRadius: json['delivery_radius'].toString(),
      restaurantImage: json['restaurant_image'],
      deliveryCharges: json['delivery_charges'].toString(),
    );
  }
}
