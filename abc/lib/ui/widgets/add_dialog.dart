import 'dart:async';

import 'package:abc/core/models/AbcItem.dart';
import 'package:abc/core/viewmodels/views/add_dialog_view_model.dart';
import 'package:abc/locator.dart';
import 'package:abc/ui/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDialog extends StatefulWidget {
  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  int _index = 0;
  List<String> _hints = ['accident', 'belief', 'consequence'];
  final _inputEditingController = TextEditingController();
  final _inputController = StreamController<bool>();
  AbcItem _abcItem = AbcItem(
    accident: null,
    belief: null,
    consequence: null,
  );

  @override
  void initState() {
    super.initState();
    _inputEditingController.addListener(_validateValue);
  }

  String _validateValue() {
    if (_inputEditingController.text == null ||
        _inputEditingController.text.isEmpty) {
      _inputController.add(true);
      return 'fill ${_hints[_index]}';
    } else {
      _inputController.add(false);
      return null;
    }
  }

  @override
  void dispose() {
    _inputController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AddDialogViewModel>(
      model: locator.get<AddDialogViewModel>(),
      builder: (context, model, child) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _inputEditingController,
                decoration: InputDecoration(
                  hintText: _hints[_index],
                  errorText: _validateValue() ?? '',
                ),
                onSubmitted: (String value) {
                  if (_index == 0) {
                    _abcItem = AbcItem.copyWith(
                      AbcItem(
                        accident: value,
                        belief: _abcItem.belief,
                        consequence: _abcItem.consequence,
                      ),
                    );
                  } else if (_index == 1) {
                    _abcItem = AbcItem.copyWith(
                      AbcItem(
                        accident: _abcItem.accident,
                        belief: value,
                        consequence: _abcItem.consequence,
                      ),
                    );
                  } else {
                    _abcItem = AbcItem.copyWith(
                      AbcItem(
                        accident: _abcItem.accident,
                        belief: _abcItem.belief,
                        consequence: value,
                      ),
                    );
                  }
                },
              ),
              Container(
                constraints: BoxConstraints(minWidth: double.infinity),
                child: StreamBuilder<bool>(
                  stream: _inputController.stream,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      color: Colors.pink,
                      textColor: Colors.white,
                      child: Text(_index == _hints.length - 1 ? 'Add' : 'Next'),
                      onPressed: !snapshot.hasData
                          ? null
                          : (snapshot.data
                              ? null
                              : () async {
                                  if (_index < _hints.length - 1) {
                                    _inputController.add(true);
                                    setState(() {
                                      _inputEditingController.clear();
                                    });
                                    _index++;
                                  } else {
                                    await model.addAbcToDatabase(_abcItem);
                                    Navigator.of(context).pop(true);
                                  }
                                }),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
