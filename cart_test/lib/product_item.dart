import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_bloc/cart_cubit.dart';
import 'product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(product.title),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                context.read<CartCubit>().update(product.id, 1);
              },
              child: Text('Add to cart'),
            ),
            // TextButton(
            //   onPressed: () {},
            //         child: Icon(Icons.remove),
            //       ),
          ],
        ),
      ),
    );
  }
}
