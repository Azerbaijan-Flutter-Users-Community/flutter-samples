import 'package:equatable/equatable.dart';
import 'package:learn_bloc_pattern/data_layer/models/hit.dart';
import 'package:meta/meta.dart';

abstract class HitState extends Equatable {
  HitState([List props = const []]) : super(props);
}

class HitUninitialized extends HitState {
  @override
  String toString() => 'HitUninitialized';
}

class HitLoading extends HitState {
  @override
  String toString() => 'HitLoading';
}

class HitFetched extends HitState {
  final List<Hit> fetchedHits;

  HitFetched({@required this.fetchedHits}) : super([fetchedHits]);

  @override
  String toString() => 'HitFetched';
}

class HitError extends HitState {
  final String errorMessage;

  HitError({@required this.errorMessage}) : super([errorMessage]);

  @override
  String toString() => 'HitError';
}
