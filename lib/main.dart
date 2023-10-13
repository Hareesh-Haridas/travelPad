import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:travel_pad/Models/favorite_model.dart';

import 'package:travel_pad/Models/profile_model.dart';
import 'package:travel_pad/Models/trip_plan_model/dream_destination_model.dart';
import 'package:travel_pad/Models/trip_plan_model/schedule_model.dart';
import 'package:travel_pad/Models/user_data_model.dart';

import 'package:travel_pad/Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ScheduledTripAdapter().typeId)) {
    Hive.registerAdapter(ScheduledTripAdapter());
  }
  if (!Hive.isAdapterRegistered(ProfileAdapter().typeId)) {
    Hive.registerAdapter(ProfileAdapter());
  }
  if (!Hive.isAdapterRegistered(DreamDestinationAdapter().typeId)) {
    Hive.registerAdapter(DreamDestinationAdapter());
  }
  if (!Hive.isAdapterRegistered(UserProfileAdapter().typeId)) {
    Hive.registerAdapter(UserProfileAdapter());
  }
  if (!Hive.isAdapterRegistered(FavoritesAdapter().typeId)) {
    Hive.registerAdapter(FavoritesAdapter());
  }
  await Hive.openBox<Favorites>('favorites');
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
