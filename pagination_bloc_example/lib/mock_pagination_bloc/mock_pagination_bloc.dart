import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../mock_repository.dart';

part 'mock_pagination_event.dart';
part 'mock_pagination_state.dart';

class MockPaginationBloc
    extends Bloc<MockPaginationEvent, MockPaginationState> {
  MockPaginationBloc() : super(MockPaginationState.initial());

  final mockRepository = MockRepository();

  @override
  Stream<MockPaginationState> mapEventToState(
      MockPaginationEvent event) async* {
    if (event is NextPageFetchRequested) {
      print('next page loading...');
      try {
        final nextPageItems =
            await mockRepository.nextPage(offset: state.items.length, limit: 5);

        if (nextPageItems.isEmpty) {
          yield state.update(reachedToEnd: true);
        } else {
          yield MockPaginationState.success(state.items + nextPageItems);
        }
      } on Exception {
        print('error!');
      }
    }
  }
}
