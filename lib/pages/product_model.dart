class Product {
  final String id;
  final String name;
  String weight;  // Non-final so it can be updated
  final double price;
  final String image;
  
  Product({
    required this.id,
    required this.name,
    required this.weight,
    required this.price,
    required this.image,
  });
  
  // Create a copy with updated weight
  Product copyWithWeight(String newWeight) {
    return Product(
      id: id,
      name: name,
      weight: newWeight,
      price: price,
      image: image,
    );
  }
}