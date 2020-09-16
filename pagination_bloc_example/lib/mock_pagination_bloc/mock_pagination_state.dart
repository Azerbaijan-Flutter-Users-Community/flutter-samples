part of 'mock_pagination_bloc.dart';

class MockPaginationState extends Equatable {
  MockPaginationState._(this.items, {this.reachedEndOfTheResults = false});

  MockPaginationState.initial() : this._([]);

  factory MockPaginationState.success(List<int> items) {
    return MockPaginationState._(items);
  }

  MockPaginationState update({bool reachedToEnd}) {
    return MockPaginationState._(items, reachedEndOfTheResults: reachedToEnd);
  }

  final List<int> items;
  final bool reachedEndOfTheResults;

  @override
  List<Object> get props => [items, reachedEndOfTheResults];
}
