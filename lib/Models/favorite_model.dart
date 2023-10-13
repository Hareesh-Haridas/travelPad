import 'package:hive/hive.dart';
part 'favorite_model.g.dart';

@HiveType(typeId: 4)
class Favorites extends HiveObject {
  @HiveField(0)
  final String name;
  Favorites(this.name);
}
