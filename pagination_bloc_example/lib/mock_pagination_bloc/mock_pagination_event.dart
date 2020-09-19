part of 'mock_pagination_bloc.dart';

abstract class MockPaginationEvent {
  const MockPaginationEvent();
}

class NextPageFetchRequested extends MockPaginationEvent with EquatableMixin {
  NextPageFetchRequested([this.currentLength = 0]);

  final int currentLength;

  @override
  List<Object> get props => [currentLength];
}

class ListRefreshRequested extends MockPaginationEvent {}
