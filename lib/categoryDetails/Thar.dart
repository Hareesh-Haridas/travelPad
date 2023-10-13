import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equatable/equatable.dart';

class TharDesertScreen extends StatefulWidget {
  // const TharDesertScreen({super.key});
  final int itemIndex;
  TharDesertScreen({required this.itemIndex});

  @override
  State<TharDesertScreen> createState() => _TharDesertScreenState();
}

class _TharDesertScreenState extends State<TharDesertScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Text(
                  'Thar desert',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  width: 120,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                initialPage: 2,
                autoPlay: true,
              ),
              items: Taj.categories
                  .map(
                    (category) => HeroCarouselCard(category: category),
                  )
                  .toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'The Thar desert is located in Asia and sits on the border between India and Pakistan. The map below shows the Thar desert location in India. The majority of the desert is in the region of Rajasthan with much smaller areas extending into the Indian regions of Punjab, Haryana, and Gujarat as well as Pakistan. The desert extends into Pakistan up to the wetter areas sustained by the Indis River.',
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w400, height: 1.9),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(60, 50),
                  backgroundColor: Colors.teal.shade700),
              onPressed: () {},
              child: Text(
                'Get Directions',
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Taj extends Equatable {
  final String imageUrl;
  const Taj({
    required this.imageUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [imageUrl];
  static List<Taj> categories = [
    const Taj(imageUrl: 'lib/assets/tharDesert.jpg'),
    const Taj(imageUrl: 'lib/assets/thar-2.jpg'),
    const Taj(imageUrl: 'lib/assets/thar-3.jpg'),
    // const Kolukku(imageUrl: 'lib/assets/kolukku-5.jpg'),
    const Taj(imageUrl: 'lib/assets/thar-4.jpg')
  ];
}

class HeroCarouselCard extends StatelessWidget {
  final Taj category;
  const HeroCarouselCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 10,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(category.imageUrl, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                // padding: const EdgeInsets.symmetric(
                //     vertical: 10.0, horizontal: 20.0),
                // child: Text(
                //   category.name,
                //   // style: const TextStyle(
                //   //   color: Colors.white,
                //   //   // fontSize: 20.0,
                //   //   //fontWeight: FontWeight.bold,
                //   // ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
