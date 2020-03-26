import 'package:flutter/material.dart';

class Skill {
  final String title;
  final double level;

  Skill({this.title, this.level});
}

class SkillsWidget extends StatelessWidget {
  final List<Skill> _professoinalSkills = [
    Skill(
      title: 'Flutter',
      level: 0.9,
    ),
    Skill(
      title: 'Dart',
      level: 0.9,
    ),
    Skill(
      title: 'BLoC (State Management)',
      level: 0.7,
    ),
    Skill(
      title: 'Provider (State Management)',
      level: 0.8,
    ),
    Skill(
      title: 'BloC Architecture',
      level: 0.9,
    ),
    Skill(
      title: 'Provider V3 Architecture',
      level: 0.78,
    ),
  ];

  final List<Skill> _personalSkilss = [
    Skill(
      title: 'Communication',
      level: 0.9,
    ),
    Skill(
      title: 'Team Work',
      level: 0.85,
    ),
    Skill(
      title: 'Communication',
      level: 0.9,
    ),
    Skill(
      title: 'English',
      level: 0.76,
    ),
    Skill(
      title: 'Communication',
      level: 0.9,
    ),
    Skill(
      title: 'Leadership',
      level: 0.65,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
        left: 100,
        right: 100,
        bottom: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Skills'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _skillWidget(
                'Professional',
              ),
              SizedBox(
                width: 30,
              ),
              _skillWidget(
                'Personal',
                true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _skillWidget(String title, [bool isPersonal = false]) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(32),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(title),
            SizedBox(
              height: 20,
            ),
            ...(isPersonal ? _personalSkilss : _professoinalSkills)
                .map(
                  (skill) => _skillIndicator(
                    skill.title,
                    skill.level,
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _skillIndicator(String title, double level) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title),
          SizedBox(
            height: 5,
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.grey,
            value: level,
            valueColor: const AlwaysStoppedAnimation(
              Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
