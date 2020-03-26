class Post {
  String id;
  final String title;
  final String body;
  final int likes;
  final String userId;

  Post({
    this.id,
    this.title,
    this.body,
    this.likes,
    this.userId,
  });

  Map<String, Object> toDocument() {
    return {
      "title": title,
      "body": body,
      "likes": likes ?? 0,
      'uid': userId,
    };
  }
}
