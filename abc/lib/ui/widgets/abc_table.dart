import 'package:abc/ui/widgets/abc_row.dart';
import 'package:flutter/material.dart';

class AbcTable extends StatelessWidget {
  final List<AbcRowItem> abcRowItems;

  AbcTable({@required this.abcRowItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: abcRowItems.length,
        itemBuilder: (context, index) => AbcRow(
              abcRowItem: abcRowItems[index],
            ));
  }
}
