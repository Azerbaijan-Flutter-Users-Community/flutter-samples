part of 'product_item_bloc.dart';

abstract class ProductItemEvent extends Equatable {
  const ProductItemEvent();
}

class AddProductToCartRequested extends ProductItemEvent {
  AddProductToCartRequested(this.product) : assert(product != null);

  final Product product;

  @override
  List<Object> get props => [product];
}
