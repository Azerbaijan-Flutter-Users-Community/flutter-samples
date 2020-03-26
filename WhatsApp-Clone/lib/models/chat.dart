import 'package:flutter/material.dart';

class Chat {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  Chat({
    this.name,
    this.message,
    this.time,
    this.avatarUrl,
  });
}

List<Chat> dummyChat = [
  Chat(
    name: 'Azerbaijan Flutter User Community',
    message: "Flutter is awasome...",
    time: "15:30",
    avatarUrl: 'assets/images/community.jpg',
  ),
  Chat(
    name: 'Azerbaijan Flutter User Community',
    message: "Flutter is awasome...",
    time: "15:30",
    avatarUrl: 'assets/images/community.jpg',
  ),
  Chat(
    name: 'Azerbaijan Flutter User Community',
    message: "Flutter is awasome...",
    time: "15:30",
    avatarUrl: 'assets/images/community.jpg',
  ),
  Chat(
    name: 'Azerbaijan Flutter User Community',
    message: "Flutter is awasome...",
    time: "15:30",
    avatarUrl: 'assets/images/community.jpg',
  ),
];