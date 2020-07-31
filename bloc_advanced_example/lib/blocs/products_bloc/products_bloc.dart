import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial());

  final List<Product> _products = [
    Product(id: 1, title: 'Bread-1', amount: 0.40),
    Product(id: 2, title: 'Bread-2', amount: 0.50),
    Product(id: 3, title: 'Bread-3', amount: 0.60),
    Product(id: 4, title: 'Bread-4', amount: 0.70),
    Product(id: 5, title: 'Bread-5', amount: 0.80),
  ];

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is LoadProductsRequested) {
      yield* _mapLoadProductsRequestedToState();
    }
  }

  Stream<ProductsState> _mapLoadProductsRequestedToState() async* {
    yield ProductInProgress();
    await Future.delayed(Duration(seconds: 2));
    yield ProductsSuccess(_products);
  }
}
