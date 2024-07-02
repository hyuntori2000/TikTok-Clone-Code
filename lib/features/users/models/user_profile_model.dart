class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;
  final String username;
  final String birthday;

  UserProfileModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.bio,
      required this.link,
      required this.username,
      required this.birthday});

  UserProfileModel.empty()
      : uid = "",
        email = "",
        bio = "",
        name = "",
        link = "",
        username = "",
        birthday = "";

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "bio": bio,
      "name": name,
      "link": link,
      "username": username,
      "birthday": birthday,
    };
  }
}
