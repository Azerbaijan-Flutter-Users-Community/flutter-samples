import 'package:flutter/material.dart';
import 'package:learn_structure/core/models/user.dart';
import 'package:learn_structure/core/viewmodels/views/home_view_model.dart';
import 'package:provider/provider.dart';
import '../shared/text_styles.dart';
import '../base_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home View'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(Provider.of<User>(context).name, style: bigTextStyle),
            ),
            Text(
              'Posts',
              style: normalTextStyle,
            ),
            BaseWidget<HomeViewModel>(
              model: HomeViewModel(api: Provider.of(context)),
              onModelReady: (model) =>
                  model.getUserPosts(Provider.of<User>(context).id),
              builder: (context, model, child) {
                return model.busy
                    ? CircularProgressIndicator()
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => ListTile(
                            leading: CircleAvatar(
                              child: Text(model.posts[index].id.toString()),
                            ),
                            title: Text(model.posts[index].title),
                            subtitle: Text(model.posts[index].body),
                          ),
                          itemCount: model.posts.length,
                        ),
                      );
              },
            ),
          ],
        ));
  }
}
