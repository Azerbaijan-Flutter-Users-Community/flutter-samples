class Product {
  Product({
    required this.id,
    required this.title,
    required this.price,
    this.count = 0,
  });

  final int id;
  final String title;
  final double price;
  int count;
}
