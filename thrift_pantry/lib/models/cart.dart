// cart_item.dart

class CartItem {
  final String storeName;
  final String productType;
  final String collectionTime;
  final double rating;
  final int distance;
  final double originalPrice;
  final double discountedPrice;
  final String imageUrl;

  CartItem({
    required this.storeName,
    required this.productType,
    required this.collectionTime,
    required this.rating,
    required this.distance,
    required this.originalPrice,
    required this.discountedPrice,
    required this.imageUrl,
  });

  // Convert a CartItem into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'storeName': storeName,
      'productType': productType,
      'collectionTime': collectionTime,
      'rating': rating,
      'distance': distance,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'imageUrl': imageUrl,
    };
  }

  // Extract a CartItem from a Map.
  static CartItem fromMap(Map<String, dynamic> map) {
    return CartItem(
      storeName: map['storeName'],
      productType: map['productType'],
      collectionTime: map['collectionTime'],
      rating: map['rating'],
      distance: map['distance'],
      originalPrice: map['originalPrice'],
      discountedPrice: map['discountedPrice'],
      imageUrl: map['imageUrl'],
    );
  }
}
