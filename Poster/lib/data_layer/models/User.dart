class User {
  final String email;
  final String displayName;
  final String uid;

  User({this.email, this.displayName, this.uid});

  Map<String, Object> toDocument() {
    return {
      'email': email,
      'display name': displayName,
    };
  }
}
