class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;
  final String username;

  UserProfileModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.bio,
      required this.link,
      required this.username});

  UserProfileModel.empty()
      : uid = "",
        email = "",
        bio = "",
        name = "",
        link = "",
        username = "";

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "bio": bio,
      "name": name,
      "link": link,
      "username": username
    };
  }
}
