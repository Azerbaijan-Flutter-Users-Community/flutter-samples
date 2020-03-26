import 'package:scoped_model/scoped_model.dart';

import 'counter.dart';

class CounterModel extends Model {
  final counter = Counter(0);

  int get count => counter.count;

  void increment() {
    counter.add();
    notifyListeners();
  }
}
