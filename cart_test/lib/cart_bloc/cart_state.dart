part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartInProgress extends CartState {}

class CartInUpdate extends CartState {
  CartInUpdate(this.products);

  final List<Product> products;
}

class CartFailure extends CartState {}

class CartSuccess extends CartState {
  CartSuccess(this.products);

  final List<Product> products;
}
