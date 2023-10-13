import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:travel_pad/Models/favorite_model.dart';
import 'package:travel_pad/Screens/detail_screen.dart';
import 'package:travel_pad/categoryList/beaches_list.dart';
import 'package:travel_pad/categoryList/desert_list.dart';
import 'package:travel_pad/categoryList/forest_list.dart';
import 'package:travel_pad/categoryList/hillstation_list.dart';
import 'package:travel_pad/categoryList/monuments_list.dart';
import 'package:travel_pad/categoryList/waterfalls_list.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Box<Favorites> _favoriteBox;
  late List<Favorites> _favoriteDestinations;
  @override
  void initState() {
    super.initState();
    _favoriteBox = Hive.box<Favorites>('favorites');
    _favoriteDestinations = _favoriteBox.values.toList().cast<Favorites>();
  }

  void _refreshFavorites() {
    setState(() {
      _favoriteDestinations = _favoriteBox.values.toList().cast<Favorites>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Favorites',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
          toolbarHeight: 75,
          backgroundColor: Colors.teal.shade700,
        ),
        body: FutureBuilder(
            future: Hive.openBox<Favorites>('favorites'),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final box = Hive.box<Favorites>('favorites');
                final favoriteDestinations =
                    box.values.toList().cast<Favorites>();
                return ListView.builder(
                    itemCount: favoriteDestinations.length,
                    itemBuilder: (context, index) {
                      final destination = favoriteDestinations[index];
                      return Card(
                        elevation: 3,
                        child: GestureDetector(
                          //onTap:
                          child: ListTile(
                            onTap: () {
                              navigateToDetailScreen(destination);
                            },
                            title: Text(destination.name),
                            trailing: IconButton(
                              onPressed: () {
                                _showDeleteConfirmationDialog(destination);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const CircularProgressIndicator();
              }
            })),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(Favorites destination) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Favorite?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete ${destination.name}?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _favoriteBox.delete(destination.key);
                _refreshFavorites();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToDetailScreen(Favorites destination) {
    final String title = destination.name;
    final Map<String, dynamic> hillstation =
        hillstations.firstWhere((item) => item['title'] == title, orElse: () {
      return <String, dynamic>{};
    });

    final Map<String, dynamic> monument =
        monuments.firstWhere((item) => item['title'] == title, orElse: () {
      return <String, dynamic>{};
    });

    final Map<String, dynamic> waterfall = waterfalls.firstWhere(
      (item) => item['title'] == title,
      orElse: () {
        return <String, dynamic>{};
      },
    );
    final Map<String, dynamic> forests = forest.firstWhere(
      (item) => item['title'] == title,
      orElse: () {
        return <String, dynamic>{};
      },
    );
    final Map<String, dynamic> beach = beaches.firstWhere(
      (item) => item['title'] == title,
      orElse: () {
        return <String, dynamic>{};
      },
    );
    final Map<String, dynamic> desert = deserts.firstWhere(
      (item) => item['title'] == title,
      orElse: () {
        return <String, dynamic>{};
      },
    );

    if (hillstation.keys.isNotEmpty) {
      navigateToDetail(hillstation);
    } else if (monument.keys.isNotEmpty) {
      navigateToDetail(monument);
    } else if (waterfall.keys.isNotEmpty) {
      navigateToDetail(waterfall);
    } else if (forests.keys.isNotEmpty) {
      navigateToDetail(forests);
    } else if (beach.keys.isNotEmpty) {
      navigateToDetail(beach);
    } else if (desert.keys.isNotEmpty) {
      navigateToDetail(desert);
    } else {
      print('destination not found $title');
    }
  }

  void navigateToDetail(Map<String, dynamic> map) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ScreenDetail(access: map)));
  }
}
