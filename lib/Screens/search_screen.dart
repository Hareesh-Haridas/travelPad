import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_pad/Screens/detail_screen.dart';
import 'package:travel_pad/categoryList/beaches_list.dart';
import 'package:travel_pad/categoryList/desert_list.dart';
import 'package:travel_pad/categoryList/forest_list.dart';
import 'package:travel_pad/categoryList/hillstation_list.dart';
import 'package:travel_pad/categoryList/monuments_list.dart';
import 'package:travel_pad/categoryList/waterfalls_list.dart';

class SeacrchScreen extends StatefulWidget {
  const SeacrchScreen({super.key});

  @override
  State<SeacrchScreen> createState() => _SeacrchScreenState();
}

class _SeacrchScreenState extends State<SeacrchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<List<String>> filteredSearchItems = [];
  FocusNode searchFieldfocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    filteredSearchItems = List.from(searchItems);
  }

  void _performSearch(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredSearchItems = searchItems.where((item) {
        return item[1].toLowerCase().contains(query);
      }).toList();

      filteredSearchItems.sort((a, b) => a[1].compareTo(b[1]));
    });
  }

  void dismisskeyboard() {
    searchFieldfocusNode.unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    searchFieldfocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Search your destination',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.teal.shade700,
        toolbarHeight: 75,
      ),
      body: GestureDetector(
        onTap: dismisskeyboard,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        focusNode: searchFieldfocusNode,
                        onChanged: _performSearch,
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _searchController.clear();
                              _performSearch('');
                            },
                            icon: const Icon(Icons.clear),
                          ),
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        Future.delayed(const Duration(milliseconds: 200), () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            final selectedDestination = collectAllDestinations()
                                .firstWhere((destination) =>
                                    destination['title'] ==
                                    filteredSearchItems[index][1]);
                            return ScreenDetail(access: selectedDestination);
                          }));
                        });
                      },
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage(filteredSearchItems[index][0]),
                        radius: 30,
                      ),
                      title: Text(filteredSearchItems[index][1]),
                    ),
                  );
                },
                childCount: filteredSearchItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<List<String>> searchItems = [
  ['lib/assets/manali.jpg', 'Manali'],
  ['lib/assets/goa.jpg', 'Goa'],
  ['lib/assets/jog-falls.jpg', 'Jog falls'],
  ['lib/assets/nandi hills.jpg', 'Nandi hills'],
  ['lib/assets/Taj-Mahal-Agra-India.jpg', 'Taj mahal'],
  ['lib/assets/bandipur-national-park-elephants.jpg', 'Bandipur national park'],
  ['lib/assets/bikaner desert.jpg', 'Bikaner desert'],
  ['lib/assets/India-Gate.jpg', 'India gate'],
  ['lib/assets/kolukku malai.jpg', 'Kolukku malai peak'],
  ['lib/assets/kovalam.jpg', 'Kovalam beach'],
  ['lib/assets/kutch.jpg', 'Kutch desert'],
  ['lib/assets/munnar.jpg', 'Munnar hill station'],
  ['lib/assets/qutab-minar.jpg', 'Qutab minar'],
  ['lib/assets/Sundarban_Tiger.jpg', 'Sundarban forest'],
  ['lib/assets/tharDesert.jpg', 'Thar desert'],
  ['lib/assets/bagaBeach.jpg', 'Baga beach'],
  ['lib/assets/girForest-1.jpg', 'Gir forest'],
  ['lib/assets/ponmudi.jpg', 'Ponmudi hills'],
  ['lib/assets/athirapally.jpg', 'Athirapally waterfalls'],
  ['lib/assets/Dudhsagar-1.jpg', 'Dudhsagar falls']
];
List<Map<String, dynamic>> collectAllDestinations() {
  List<Map<String, dynamic>> allDestinations = [];
  allDestinations.addAll(waterfalls);
  allDestinations.addAll(hillstations);
  allDestinations.addAll(monuments);
  allDestinations.addAll(forest);
  allDestinations.addAll(beaches);
  allDestinations.addAll(deserts);
  return allDestinations;
}
