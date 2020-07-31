part of 'product_item_bloc.dart';

abstract class ProductItemState extends Equatable {
  const ProductItemState();

  @override
  List<Object> get props => [];
}

class ProductItemInitial extends ProductItemState {}

class ProductItemToCartInProgress extends ProductItemState {}
