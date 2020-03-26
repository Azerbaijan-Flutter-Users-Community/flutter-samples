import 'package:flutter/material.dart';
import '../models/chat.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyChat.length,
      itemBuilder: (context, index) => Column(children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
              dummyChat[index].avatarUrl,
            ),
          ),
          title: Text(dummyChat[index].name,
          softWrap: true,
          overflow: TextOverflow.ellipsis,),
          subtitle: Text(dummyChat[index].message),
          trailing: Text(
            dummyChat[index].time,
          ),
        ),
        Divider(),
      ],
      ),
    );
  }
}