part of 'products_bloc.dart';

@immutable
abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductInProgress extends ProductsState {}

class ProductsFailure extends ProductsState {}

class ProductsSuccess extends ProductsState {
  ProductsSuccess(this.products) : assert(products != null);

  final List<Product> products;

  @override
  List<Object> get props => [products];
}
