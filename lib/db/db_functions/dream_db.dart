import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:travel_pad/Models/trip_plan_model/dream_destination_model.dart';

ValueNotifier<List<DreamDestination>> DreamDestinationNotifier =
    ValueNotifier([]);
const dreamDbName = 'dreamDestination';
void addDream(DreamDestination dream) async {
  final dreamDB = await Hive.openBox<DreamDestination>(dreamDbName);
  dreamDB.add(dream);
  print(dreamDB.values);
  getAllDream();
}

void getAllDream() async {
  final dreamDB = await Hive.openBox<DreamDestination>(dreamDbName);
  DreamDestinationNotifier.value.clear();
  DreamDestinationNotifier.value.addAll(dreamDB.values);
  DreamDestinationNotifier.notifyListeners();
}

void updateDream(int index, DreamDestination dream) async {
  final dreamDB = await Hive.openBox<DreamDestination>(dreamDbName);
  dreamDB.putAt(index, dream);
  getAllDream();
}

void deleteDream(DreamDestination dream) async {
  final dreamDB = await Hive.openBox<DreamDestination>(dreamDbName);
  dream.delete();
  getAllDream();
}
