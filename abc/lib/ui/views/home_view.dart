import 'package:abc/core/viewmodels/views/home_view_model.dart';
import 'package:abc/locator.dart';
import 'package:abc/ui/base_widget.dart';
import 'package:abc/ui/widgets/abc_cell.dart';
import 'package:abc/ui/widgets/abc_row.dart';
import 'package:abc/ui/widgets/abc_table.dart';
import 'package:abc/ui/widgets/add_dialog.dart';
import 'package:abc/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _homeViewModel = locator.get<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: AbcRow(
          abcRowItem: AbcRowItem(
            abcCellItems: [
              AbcCellItem(
                  content: 'A', message: 'Activating Events / Accidents'),
              AbcCellItem(content: 'B', message: 'Beliefs'),
              AbcCellItem(content: 'C', message: 'Consequences'),
              AbcCellItem(
                content: 'Dates',
              ),
            ],
            isHeaderRow: true,
          ),
        ),
      ),
      body: BaseWidget<HomeViewModel>(
        model: _homeViewModel,
        onModelReady: (model) => model.getAllAbcItems(),
        builder: (context, model, child) => model.busy
            ? Loading()
            : model.abcItems.isEmpty
                ? Center(
                    child: Text('There is no item yet...'),
                  )
                : AbcTable(
                    abcRowItems: model.abcItems
                        .map(
                          (abcItem) => AbcRowItem(
                              abcRowId: abcItem.abcId,
                              abcCellItems: [
                                AbcCellItem(content: abcItem.accident),
                                AbcCellItem(content: abcItem.belief),
                                AbcCellItem(content: abcItem.consequence),
                                AbcCellItem(content: abcItem.dateTime),
                              ]),
                        )
                        .toList(),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showAddDialog(context),
      ),
    );
  }

  void showAddDialog(BuildContext context) async {
    bool result =
        await showDialog(context: context, builder: (context) => AddDialog());
    if (result != null && result) {
      await _homeViewModel.getAllAbcItems();
    }
  }
}
