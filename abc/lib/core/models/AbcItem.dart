import 'package:meta/meta.dart';

class AbcItem {
  int _abcId;
  String _accident;
  String _belief;
  String _consequence;
  String _dateTime;

  AbcItem({
    int abcId,
    @required String accident,
    @required String belief,
    @required String consequence,
    String dateTime,
  }) {
    this._abcId = abcId;
    this._accident = accident;
    this._belief = belief;
    this._consequence = consequence;

    if (_dateTime == null)
      this._dateTime = DateTime.now().toIso8601String();
    else
      this._dateTime = dateTime;
  }

  int get abcId => _abcId;

  String get accident => _accident;

  String get belief => _belief;

  String get consequence => _consequence;

  String get dateTime => _dateTime;

  set abcId(int abcId) => this._abcId = abcId;

  set accident(String accident) => this.accident = accident;

  set belief(String belief) => this._belief = belief;

  set consequence(String consequence) => this._consequence = consequence;

  set dateTime(String dateTime) => this._dateTime = dateTime;

  Map<String, dynamic> toMap() => {
        "abcId": abcId,
        "abcAccident": accident,
        "abcBelief": belief,
        "abcConsequence": consequence,
        "abcDateTime": dateTime,
      };

  factory AbcItem.fromMap(Map<dynamic, dynamic> json) => new AbcItem(
        abcId: json["abcId"],
        accident: json["abcAccident"],
        belief: json["abcBelief"],
        consequence: json["abcConsequence"],
        dateTime: json['abcDateTime'],
      );

  factory AbcItem.copyWith(AbcItem abcItem) {
    return AbcItem(
      accident: abcItem.accident,
      belief: abcItem.belief,
      consequence: abcItem.consequence,
      dateTime: DateTime.now().toIso8601String(),
    );
  }

  @override
  String toString() => '''
  abcAccident: $_accident,
  abcBelief: $_belief,
  abcConsequence: $_consequence,
  abcDateTime: $_dateTime,
  ''';

}
