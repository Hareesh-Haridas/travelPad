import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:travel_pad/Models/trip_plan_model/schedule_model.dart';

ValueNotifier<List<ScheduledTrip>> scheduledTripListNotifier =
    ValueNotifier([]);
const tripDbName = 'scheduledTrip';
void addTrip(ScheduledTrip trip) async {
  final tripDB = await Hive.openBox<ScheduledTrip>(tripDbName);
  tripDB.add(trip);
  getAllTrips();
}

void getAllTrips() async {
  final tripDB = await Hive.openBox<ScheduledTrip>(tripDbName);
  scheduledTripListNotifier.value.clear();
  scheduledTripListNotifier.value.addAll(tripDB.values);
  scheduledTripListNotifier.notifyListeners();
}

void deleteTrip(ScheduledTrip trip) async {
  final tripDB = await Hive.openBox<ScheduledTrip>(tripDbName);
  trip.delete();
  getAllTrips();
}

void editTrip(ScheduledTrip editedTrip, date) async {
  final tripDB = await Hive.openBox<ScheduledTrip>(tripDbName);
  final index = tripDB.values.toList().indexWhere((trip) => trip.date == date);
  await tripDB.putAt(index, editedTrip);
  getAllTrips();
}

bool listsAreEqual(List<String> list1, List<String> list2) {
  if (list1.length != list2.length) {
    return false;
  }

  for (int i = 0; i < list1.length; i++) {
    if (list1[i] != list2[i]) {
      return false;
    }
  }

  return true;
}
