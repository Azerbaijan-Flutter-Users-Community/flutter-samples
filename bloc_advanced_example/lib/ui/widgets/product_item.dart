import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product.dart';
import '../../blocs/product_item_bloc/product_item_bloc.dart';
import '../../blocs/cart_bloc/cart_bloc.dart';



class ProductItem extends StatefulWidget {
  const ProductItem({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  ProductItemBloc productItemBloc;

  @override
  void initState() {
    productItemBloc = ProductItemBloc(BlocProvider.of<CartBloc>(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   BlocBuilder<ProductItemBloc, ProductItemState>(
      cubit: productItemBloc,
      builder: (context, productItemState) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Center(
                child: Text('${widget.product.id}'),
              ),
            ),
            title: Text(widget.product.title),
            subtitle: Text('${widget.product.amount} AZN'),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: widget.product.isAddedToCart ||
                productItemState is ProductItemToCartInProgress ? null : () {
                productItemBloc.add(AddProductToCartRequested(widget.product));
              },
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    productItemBloc?.close();
    super.dispose();
  }
}
