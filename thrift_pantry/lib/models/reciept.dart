// receipt.dart

class Receipt {
  final int? id; // Nullable for when inserting new data
  final String storeName;
  final String productType;
  final double price; // Original price
  final double discountedPrice; // Discounted price
  final double totalPrice; // Final total price paid
  final String collectionTime; // Collection time for the item
  final String date; // Date of the transaction

  Receipt({
    this.id,
    required this.storeName,
    required this.productType,
    required this.price,
    required this.discountedPrice,
    required this.totalPrice,
    required this.collectionTime,
    required this.date,
  });

  // Convert Receipt object to a map (for database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storeName': storeName,
      'productType': productType,
      'price': price,
      'discountedPrice': discountedPrice,
      'totalPrice': totalPrice,
      'collectionTime': collectionTime,
      'date': date,
    };
  }

  // Create a Receipt object from a map (for fetching from database)
  factory Receipt.fromMap(Map<String, dynamic> map) {
    return Receipt(
      id: map['id'],
      storeName: map['storeName'],
      productType: map['productType'],
      price: map['price'],
      discountedPrice: map['discountedPrice'],
      totalPrice: map['totalPrice'],
      collectionTime: map['collectionTime'],
      date: map['date'],
    );
  }
}
