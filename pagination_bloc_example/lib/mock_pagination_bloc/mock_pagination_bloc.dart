import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../mock_repository.dart';

part 'mock_pagination_event.dart';
part 'mock_pagination_state.dart';

class MockPaginationBloc
    extends Bloc<MockPaginationEvent, MockPaginationState> {
  MockPaginationBloc() : super(MockPaginationState.initial());

  final mockRepository = MockRepository();

  @override
  void onEvent(MockPaginationEvent event) {
    super.onEvent(event);
    final fetchEvent = event as NextPageFetchRequested;
    debugPrint('${fetchEvent.runtimeType} => ${fetchEvent.currentLength}');
  }

  @override
  Stream<MockPaginationState> mapEventToState(
      MockPaginationEvent event) async* {
    if (state.reachedEndOfTheResults) return;

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
