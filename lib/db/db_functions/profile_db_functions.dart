import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_pad/Models/profile_model.dart';

ValueNotifier<List<UserProfile>> userProfileNotifier = ValueNotifier([]);
const userPrifileDBname = 'userProfile';
void addUserProfile(UserProfile data) async {
  final userProfileDB = await Hive.openBox<UserProfile>(userPrifileDBname);
  userProfileDB.add(data);
}

const userProfile = 'username';
Future editUserName(String name) async {
  final sharedPreference = await SharedPreferences.getInstance();
  sharedPreference.setString(userProfile, name);
}

const userProfileImage = 'userProfileImage';
Future editUserImage(String image) async {
  final sharedPreference = await SharedPreferences.getInstance();
  sharedPreference.setString(userProfileImage, image);
}

Future<UserProfile> getUserProfile() async {
  final sharedPreference = await SharedPreferences.getInstance();
  final user = UserProfile(
      profilePicture: sharedPreference.getString(userProfileImage) ?? '',
      userName: sharedPreference.getString(userProfile) ?? '');
  return user;
}
