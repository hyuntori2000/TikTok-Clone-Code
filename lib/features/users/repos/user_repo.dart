import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage =
      FirebaseStorage.instance; // give direct access to firebasestoage.
//create profile
  Future<void> createPRofile(UserProfileModel profile) async {
    await _db
        .collection("users")
        .doc(profile.uid)
        .set(profile.toJson()); // putting the UserProfileMNodel to database
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> uploadAvatar(File file, String fileName) async {
    final fileRef = _storage.ref().child(
        "avatars/$fileName"); // makeing space that we store file and named it.
    final task = await fileRef.putFile(
        file); // add the image file into it. by defining it as a yask I can see the status of put file and control it.
  }

  //this only talk with firebase that is why we save this method in the repositroy.

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(
        data); // by sending uid it recognize which user is the fuction will update.
  }
//update profile
// get profile
}

final userRepo = Provider((ref) => UserRepository());
