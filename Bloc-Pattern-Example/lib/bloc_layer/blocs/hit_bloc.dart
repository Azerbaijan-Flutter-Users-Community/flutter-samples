import 'dart:async';

import 'package:learn_bloc_pattern/bloc_layer/bloc.dart';
import 'package:learn_bloc_pattern/bloc_layer/events/hit_event.dart';
import 'package:learn_bloc_pattern/bloc_layer/states/hit_state.dart';
import 'package:learn_bloc_pattern/data_layer/repository/hit_repository.dart';
import 'package:meta/meta.dart';

class HitBloc implements Bloc {
  final HitRepository hitRepository;

  HitBloc({@required this.hitRepository}) : assert(hitRepository != null) {
    _hitEventController.stream.listen(_onHitEventReceived);
  }

  HitState get initialState => HitUninitialized();

  // for input
  final _hitEventController = StreamController<HitEvent>.broadcast();
  Sink<HitEvent> get hitEventSink => _hitEventController.sink;

  // for output
  final _hitStateController = StreamController<HitState>();
  Stream<HitState> get hitStateStream => _hitStateController.stream;

  _onHitEventReceived(HitEvent event) async {
    if (event is GetHitsEvent) {
      try {
        _hitStateController.sink.add(HitLoading());
        final fetchedHits = await hitRepository.getHitsList(event.query);
        _hitStateController.sink.add(HitFetched(fetchedHits: fetchedHits));
      } catch (error) {
        _hitStateController.sink.add(HitError(errorMessage: error.toString()));
      }
    }

    if (event is EmptyQueryEvent) {
      _hitStateController.sink.add(HitUninitialized());
    }

    if (event is FavoriteButtonClickedEvent) {
      bool isFavorite = event.clickedHit.isFavorite;

      hitRepository.currentHits.firstWhere(
          (hit) => hit.id == event.clickedHit.id)
        ..isFavorite = !event.clickedHit.isFavorite
        ..likes = isFavorite ? --event.clickedHit.likes : ++event.clickedHit.likes;
      _hitStateController.sink
          .add(HitFetched(fetchedHits: hitRepository.currentHits));
    }
  }

  @override
  void dispose() {
    _hitEventController.close();
    _hitStateController.close();
  }
}
