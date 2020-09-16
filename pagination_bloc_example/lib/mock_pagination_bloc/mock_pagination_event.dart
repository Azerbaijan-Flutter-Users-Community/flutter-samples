part of 'mock_pagination_bloc.dart';

abstract class MockPaginationEvent {
  const MockPaginationEvent();
}

class NextPageFetchRequested extends MockPaginationEvent {}
