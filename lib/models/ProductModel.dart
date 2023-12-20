class ProductModel {
  String? name;
  String? description;
  String? price;
  List<dynamic>? category;
  List<dynamic>? images;
  int? rate;

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.images,
    this.rate
  });
}
