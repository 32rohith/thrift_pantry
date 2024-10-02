class FarmCartItem {
  final String storeName;
  final String productType;
  final String deliverBy;
  final double rating;
  final int distance;
  final double originalPrice;
  final double discountedPrice;
  final String imageUrl;

  FarmCartItem({
    required this.storeName,
    required this.productType,
    required this.deliverBy,
    required this.rating,
    required this.distance,
    required this.originalPrice,
    required this.discountedPrice,
    required this.imageUrl,
  });

  // Convert a FarmCartItem to a map to save it in SQLite
  Map<String, dynamic> toMap() {
    return {
      'storeName': storeName,
      'productType': productType,
      'deliverBy': deliverBy,
      'rating': rating,
      'distance': distance,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'imageUrl': imageUrl,
    };
  }

  // Convert map from SQLite to FarmCartItem
  static FarmCartItem fromMap(Map<String, dynamic> map) {
    return FarmCartItem(
      storeName: map['storeName'],
      productType: map['productType'],
      deliverBy: map['deliverBy'],
      rating: map['rating'],
      distance: map['distance'],
      originalPrice: map['originalPrice'],
      discountedPrice: map['discountedPrice'],
      imageUrl: map['imageUrl'],
    );
  }
}
