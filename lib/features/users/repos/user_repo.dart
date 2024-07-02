import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
//create profile
  Future<void> createPRofile(UserProfileModel profile) async {
    await _db
        .collection("users")
        .doc(profile.uid)
        .set(profile.toJson()); // putting the UserProfileMNodel to database
  }
//update profile
// get profile
}

final userRepo = Provider((ref) => UserRepository());
