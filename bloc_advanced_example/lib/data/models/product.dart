class Product {
  Product({
    this.id,
    this.title,
    this.amount,
    this.isAddedToCart = false,
  });

  final int id;
  final String title;
  final double amount;
  bool isAddedToCart;
}
