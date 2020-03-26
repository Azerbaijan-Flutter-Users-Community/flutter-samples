import 'package:flutter/material.dart';

class AbcCell extends StatelessWidget {
  final AbcCellItem abcCellItem;

  AbcCell({@required this.abcCellItem});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Tooltip(
        message: abcCellItem.message ?? (abcCellItem.content ?? 'delete'),
        child: Container(
          constraints: BoxConstraints(
            minHeight: 50,
          ),
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text(
              abcCellItem.content,
            ),
          ),
        ),
      ),
    );
  }
}

class AbcCellItem {
  String content;
  String message;

  AbcCellItem({@required this.content, this.message});
}
