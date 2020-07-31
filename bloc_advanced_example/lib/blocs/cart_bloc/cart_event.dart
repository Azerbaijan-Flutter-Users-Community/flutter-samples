part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddItemToCartRequested extends CartEvent {
  AddItemToCartRequested(this.product): assert(product != null);
  final Product product;

  @override
  List<Object> get props => [product];
}