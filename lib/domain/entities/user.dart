class User {
  final String username;
  final String displayName;

  User(this.username, this.displayName);

  User.fromJson(Map<String, dynamic> map)
      : username = map['username'],
        displayName = map['displayName'];
}
