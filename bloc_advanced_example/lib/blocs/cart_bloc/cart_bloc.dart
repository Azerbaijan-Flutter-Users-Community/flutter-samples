import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartRefresh());

  final List<Product> cartProducts = [];

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if(event is AddItemToCartRequested) {
      final product = event.product;
      if(!cartProducts.contains(product)) {
        cartProducts.add(product);
        product.isAddedToCart = true;
      } else {
        cartProducts.remove(product);
        product.isAddedToCart = false;
      }

      yield CartRefresh(cartProducts.length);
    }
  }
}
