const mockItems = <int>[1, 5, 7, 45, 3, 54, 2, 6, 9, 18, 21, 25, 36, 43];

class MockRepository {
  Future<List<int>> nextPage({int offset, int limit}) async {
    await Future.delayed(Duration(seconds: 2));
    final items = mockItems.skip(offset).take(limit).toList();
    return items;
  }
}
