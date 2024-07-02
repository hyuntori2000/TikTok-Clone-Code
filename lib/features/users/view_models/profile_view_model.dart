import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/profile_model.dart';

class ProfileViewModel extends AsyncNotifier<ProfileModel> {
  @override
  build() {
    return ProfileModel(
      inputName: "",
      inputBirthday: "",
    );
  }

  void setInputName(String name) {
    state = AsyncValue.data(ProfileModel(
      inputName: name,
      inputBirthday: state.value!.inputBirthday,
    ));
  }

  void setInputBirthday(String birthday) {
    state = AsyncValue.data(ProfileModel(
      inputName: state.value!.inputName,
      inputBirthday: birthday,
    ));
  }
}

final profileViewModel = AsyncNotifierProvider<ProfileViewModel, ProfileModel>(
  () => ProfileViewModel(),
);
