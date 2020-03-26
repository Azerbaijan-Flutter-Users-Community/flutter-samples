import 'package:abc/core/viewmodels/views/home_view_model.dart';
import 'package:abc/locator.dart';
import 'package:abc/ui/widgets/abc_cell.dart';
import 'package:flutter/material.dart';

class AbcRow extends StatelessWidget {
  final AbcRowItem abcRowItem;

  AbcRow({this.abcRowItem});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: abcRowItem.isHeaderRow ? true : false,
      child: Dismissible(
        secondaryBackground: Container(
          color: Colors.pink,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
            ],
          ),
        ),
        background: Container(
          color: Colors.pink,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
            ],
          ),
        ),
        onDismissed: (direction) {
          locator.get<HomeViewModel>().deleteAbcFromDb(abcRowItem.abcRowId);
        },
        key: Key(abcRowItem.abcRowId.toString()),
        child: Container(
          decoration: BoxDecoration(
            color: abcRowItem.isHeaderRow ? Colors.pink : Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: abcRowItem.isHeaderRow ? Colors.pink : Colors.grey,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: abcRowItem.abcCellItems
                .map((abcCell) => AbcCell(
                      abcCellItem: abcCell,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class AbcRowItem {
  final List<AbcCellItem> abcCellItems;
  final bool isHeaderRow;
  final int abcRowId;

  AbcRowItem({this.abcCellItems, this.isHeaderRow = false, this.abcRowId});
}
