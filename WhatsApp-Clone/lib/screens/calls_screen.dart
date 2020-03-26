import 'package:flutter/material.dart';
import '../models/chat.dart';

class CallsScreen extends StatelessWidget {
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
          subtitle: Row(children: <Widget>[
            Icon(Icons.call_made, color: Theme.of(context).accentColor,),
            Text(dummyChat[index].time),
          ],),
          trailing: Icon(
            Icons.call,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Divider(),
      ],
      ),
    );;
  }
}