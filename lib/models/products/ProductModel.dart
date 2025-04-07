class ProductModel {
  String id;
  String title;
  String description;
  String category;
  double price;
  bool isAvailable;
  String priceDescription;
  List<String> imageUrls; // تعديل الحقل ليكون قائمة من النصوص

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.isAvailable,
    required this.priceDescription,
    required this.imageUrls,
  });

  // Factory constructor to create ProductModel from a map
  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      isAvailable: map['isAvailable'] ?? true,
      priceDescription: map['priceDescription'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []), // تعديل هنا
    );
  }

  // Convert ProductModel object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'isAvailable': isAvailable,
      'priceDescription': priceDescription,
      'imageUrls': imageUrls,
    };
  }
}
