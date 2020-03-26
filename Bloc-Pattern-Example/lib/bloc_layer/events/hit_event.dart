import 'package:equatable/equatable.dart';
import 'package:learn_bloc_pattern/data_layer/models/hit.dart';
import 'package:meta/meta.dart';

abstract class HitEvent extends Equatable {
  HitEvent([List props = const []]) : super(props);
}

class GetHitsEvent extends HitEvent {
  final String query;

  GetHitsEvent({@required this.query}) : super([query]);

  @override
  String toString() => 'GetHitsEvent';
}

class EmptyQueryEvent extends HitEvent {
  @override
  String toString() => 'EmptyQueryEvent';
}

class FavoriteButtonClickedEvent extends HitEvent {
  final Hit clickedHit;

  FavoriteButtonClickedEvent({@required this.clickedHit}) : super([clickedHit]);
}
