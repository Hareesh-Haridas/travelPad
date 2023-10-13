import 'package:hive/hive.dart';
part 'user_data_model.g.dart';

@HiveType(typeId: 1)
class Profile extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final String email;
  Profile({required this.username, required this.password, this.email = ''});
}
