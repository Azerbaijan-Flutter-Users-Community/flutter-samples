import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Hit extends Equatable{
  final int id;
  final String user;
  int likes;
  final String webFormatUrl;
  bool isFavorite;

  Hit({
    @required this.id,
    @required this.user,
    @required this.likes,
    @required this.webFormatUrl,
    this.isFavorite = false,
  }): super([id, user, likes, webFormatUrl, isFavorite]);
  

  factory Hit.fromJson(Map<String, dynamic> json){
    return Hit(
        id: json['id'],
        user: json['user'],
        likes: json['likes'],
        webFormatUrl: json['webformatURL']
    );
  }
}