class HitItem {
  final String largeImageUrl;
  final int likes;
  final String user;

  HitItem({
    this.largeImageUrl,
    this.likes,
    this.user
  });

  factory HitItem.formJson(Map<String, dynamic> json){
    return HitItem(
      largeImageUrl: json['largeImageURL'],
      likes: json['likes'],
      user: json['user'],
    );
  }
}