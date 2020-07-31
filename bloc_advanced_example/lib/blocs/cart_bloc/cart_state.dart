part of 'cart_bloc.dart';

@immutable
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartRefresh extends CartState {
  CartRefresh([int count]) : itemCount = count ?? 0;

  final int itemCount;

  @override
  List<Object> get props => [itemCount];
}
