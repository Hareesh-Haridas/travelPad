import 'package:flutter/material.dart';
import 'package:travel_pad/categoryList/beaches_list.dart';
import 'package:travel_pad/categoryList/desert_list.dart';
import 'package:travel_pad/categoryList/forest_list.dart';
import 'package:travel_pad/categoryList/hillstation_list.dart';
import 'package:travel_pad/categoryList/monuments_list.dart';
import 'package:travel_pad/categoryList/waterfalls_list.dart';

List<Map<String, dynamic>> getDestinationsByCategoryHelper(String category) {
  if (category == 'Hill stations') {
    return hillstations;
  } else if (category == 'Monuments') {
    return monuments;
  } else if (category == 'Waterfalls') {
    return waterfalls;
  } else if (category == 'Forests') {
    return forest;
  } else if (category == 'Beaches') {
    return beaches;
  } else {
    return deserts;
  }
}

ValueNotifier<List<Map<String, dynamic>>> categorylistNotifier =
    ValueNotifier([]);
getDestinationsByCategory(String category) {
  final list = getDestinationsByCategoryHelper(category);
  categorylistNotifier.value.clear();
  categorylistNotifier.value.addAll(list);
  categorylistNotifier.notifyListeners();
}
