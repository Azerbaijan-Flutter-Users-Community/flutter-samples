import 'package:flutter_bloc/flutter_bloc.dart';

import '../mocks.dart';
import '../product.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void fetch() async {
    emit(CartInProgress());
    await Future.delayed(Duration(seconds: 3));
    emit(CartSuccess(products));
  }

  void update(int productId, int count) async {
    emit(CartInUpdate(products));

    await Future.delayed(Duration(milliseconds: 500));
    final product = products.firstWhere((product) => product.id == productId);
    product.count = count;
    emit(CartSuccess(products));
  }
}
