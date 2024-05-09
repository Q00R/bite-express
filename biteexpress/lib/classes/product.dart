class Product {
  final String productId;
  final String title;
  final String description;
  final String createdVendor;
  final String price;
  final String image;
  final String category;
  final String subcategory;
  final Map<String, int> ratings;
  final Map<String, Map<String, String>> comments;

  Product({
    required this.productId,
    required this.title,
    required this.description,
    required this.createdVendor,
    required this.image,
    required this.category,
    required this.subcategory,
    required this.price,
    required this.ratings,
    required this.comments,
  });
}
