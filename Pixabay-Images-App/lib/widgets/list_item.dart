import 'package:flutter/material.dart';
import '../models/hit_item.dart';

class ListItem extends StatelessWidget {
  final HitItem currentHitItem;

  ListItem(this.currentHitItem);

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.all(10),
          width: double.infinity,
          height: 300,
          child: Card(
              elevation: 8,
              child: Column(children: <Widget>[
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: currentHitItem.largeImageUrl == null ?
                    Text('Null'): 
                    Image.network(currentHitItem.largeImageUrl,
                    fit: BoxFit.cover,),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(currentHitItem.user),
                      Text(currentHitItem.likes.toString()),                    
                  ],),
                  ),
                ),
              ],),
            ),
          );
  }
}