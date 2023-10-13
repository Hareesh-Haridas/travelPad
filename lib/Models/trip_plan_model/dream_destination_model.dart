import 'package:hive/hive.dart';
part 'dream_destination_model.g.dart';

@HiveType(typeId: 2)
class DreamDestination extends HiveObject {
  @HiveField(0)
  final String place;
  @HiveField(1)
  final double savings;
  @HiveField(2)
  final int expense;

  DreamDestination({
    required this.place,
    required this.savings,
    required this.expense,
  });
}
