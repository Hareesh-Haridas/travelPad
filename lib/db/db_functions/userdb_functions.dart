import 'package:hive/hive.dart';
import 'package:travel_pad/Models/user_data_model.dart';

const profileDbName = 'profile';
void addUser(Profile profiles) async {
  final profileDB = await Hive.openBox<Profile>(profileDbName);
  profileDB.add(profiles);
}
