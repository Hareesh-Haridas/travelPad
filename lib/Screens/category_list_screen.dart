import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:travel_pad/Models/favorite_model.dart';
import 'package:travel_pad/Models/trip_plan_model/dream_destination_model.dart';
import 'package:travel_pad/Screens/detail_screen.dart';
import 'package:travel_pad/functions/functions.dart';

class ScreenCategoryList extends StatefulWidget {
  const ScreenCategoryList({super.key, required this.name});
  final String name;

  @override
  State<ScreenCategoryList> createState() => _ScreenCategoryListState();
}

class _ScreenCategoryListState extends State<ScreenCategoryList> {
  ValueNotifier<List<Favorites>> favoritesNotifier =
      ValueNotifier<List<Favorites>>([]);
  Set<String> favoriteDestinations = Set<String>();
  @override
  void initState() {
    findFav();
    super.initState();
  }

  findFav() async {
    final box = await Hive.openBox<Favorites>('favorites');
    for (var element in box.values) {
      favoriteDestinations.add(element.name);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getDestinationsByCategory(widget.name);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.teal.shade700,
        toolbarHeight: 75,
      ),
      body: ValueListenableBuilder(
        valueListenable: categorylistNotifier,
        builder: (context, list, _) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final destinationName = list[index]['title'];
              bool isFavorite = favoriteDestinations.contains(destinationName);
              void toggleFavorite() async {
                final box = await Hive.openBox<Favorites>('favorites');
                if (isFavorite) {
                  favoriteDestinations.remove(destinationName);
                  box.delete(destinationName);
                } else {
                  favoriteDestinations.add(destinationName);
                  await box.put(destinationName, Favorites(destinationName));
                }
                final updatedList = list.map((destination) {
                  final destinationName = destination['title'];
                  final isFavorite =
                      favoriteDestinations.contains(destinationName);
                  destination['isFavorite'] = isFavorite;
                  return destination;
                }).toList();
                categorylistNotifier.value = updatedList;
                favoritesNotifier.value = favoriteDestinations
                    .map((name) => Favorites(name))
                    .toList();
              }

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ScreenDetail(access: list[index]),
                    ),
                  );
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(list[index]['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  list[index]['title'],
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  toggleFavorite();
                                },
                                icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFavorite ? Colors.red : Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: list.length,
          );
        },
      ),
    );
  }
}
