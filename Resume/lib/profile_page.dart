import 'package:flutter/material.dart';
import 'package:resume/responsive_widget.dart';
import 'package:resume/skill_widget.dart';

import 'about_widget.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: Scaffold(
        backgroundColor: Colors.grey[100],
        drawer: ResponsiveWidget.isSmallScreen(context)
            ? Drawer(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: <Widget>[],
                ),
              )
            : null,
        body: ListView(
          children: <Widget>[
            AboutWidget(),
            SkillsWidget(),
          ],
        ),
      ),
    );
  }
}
