import 'package:hive/hive.dart';
part 'schedule_model.g.dart';

@HiveType(typeId: 0)
class ScheduledTrip extends HiveObject {
  @HiveField(0)
  String destination;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  List<String> selectedcontacts;
  @HiveField(3)
  double? totalExpenseAmount;
  @HiveField(4)
  double? splitAmount;
  ScheduledTrip(
      {required this.destination,
      required this.date,
      required this.selectedcontacts,
      this.totalExpenseAmount,
      this.splitAmount});
}
