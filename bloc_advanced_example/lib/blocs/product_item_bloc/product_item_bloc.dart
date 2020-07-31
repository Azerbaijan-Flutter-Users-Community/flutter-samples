import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/product.dart';
import '../cart_bloc/cart_bloc.dart';

part 'product_item_event.dart';
part 'product_item_state.dart';

class ProductItemBloc extends Bloc<ProductItemEvent, ProductItemState> {
  ProductItemBloc(this.cartBloc) : super(ProductItemInitial()){
   cartBlocSubscription = cartBloc.listen((cartState) {
   });
  }

  final CartBloc cartBloc;
  StreamSubscription cartBlocSubscription;

  @override
  Stream<ProductItemState> mapEventToState(
    ProductItemEvent event,
  ) async* {
    if(event is AddProductToCartRequested) {
      yield* _mapAddProductToCartRequested(event.product);
    }
  }

  Stream<ProductItemState> _mapAddProductToCartRequested(Product selectedProduct) async* {
    yield ProductItemToCartInProgress();
    cartBloc.add(AddItemToCartRequested(selectedProduct));
    yield ProductItemInitial();
  }

  @override
  Future<void> close() {
    cartBlocSubscription?.cancel();
    return super.close();
  }
}
