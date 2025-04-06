class Product {
  final String id;
  final String name;
  final String weight;
  final double price;  // Make sure this is explicitly a double
  final String image;
  
  Product({
    required this.id,
    required this.name,
    required this.weight,
    required this.price,
    required this.image,
  });
}