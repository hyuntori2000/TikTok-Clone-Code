class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;
  final String username;
  final String birthday;
  final bool hasAvatar;

  UserProfileModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.bio,
      required this.link,
      required this.username,
      required this.birthday,
      required this.hasAvatar});

  UserProfileModel.empty()
      : uid = "",
        email = "",
        bio = "",
        name = "",
        link = "",
        username = "",
        birthday = "",
        hasAvatar = false;

// This should recieve Map<String,dynamic> because the data from firebase look like that.
  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email = json["email"],
        bio = json["bio"],
        name = json["name"],
        link = json["link"],
        username = json["username"],
        birthday = json["birthday"],
        hasAvatar = json["hasAvatar"];

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

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? bio,
    String? link,
    String? username,
    String? birthday,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
        bio: bio ?? this.bio,
        link: link ?? this.link,
        username: username ?? this.username,
        birthday: birthday ?? this.birthday,
        hasAvatar: hasAvatar ?? this.hasAvatar);
  } // copuWith method will build the state completely new using the data from past data and currunt add on.
}
