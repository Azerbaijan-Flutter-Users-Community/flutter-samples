part of 'mock_pagination_bloc.dart';

abstract class MockPaginationEvent extends Equatable {
  const MockPaginationEvent();

  @override
  List<Object> get props => [];
}

class NextPageFetchRequested extends MockPaginationEvent {
  NextPageFetchRequested([this.currentLength = 0]);

  final int currentLength;

  @override
  List<Object> get props => [currentLength];
}
