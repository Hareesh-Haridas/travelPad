import 'package:hive/hive.dart';
part 'profile_model.g.dart';

@HiveType(typeId: 3)
class UserProfile extends HiveObject {
  @HiveField(0)
  String profilePicture;
  @HiveField(1)
  String userName;
  UserProfile({required this.profilePicture, required this.userName});
}
