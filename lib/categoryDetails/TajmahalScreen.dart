import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equatable/equatable.dart';

class TajMahalScreen extends StatefulWidget {
  //const TajMahalScreen({super.key});
  final int itemIndex;
  TajMahalScreen({required this.itemIndex});
  @override
  State<TajMahalScreen> createState() => _TajMahalScreenState();
}

class _TajMahalScreenState extends State<TajMahalScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 25,
                ),
                const Text(
                  'Taj Mahal',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  width: 120,
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.favorite_outline))
              ],
            ),
            const SizedBox(
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
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'The Taj Mahal is an ivory-white marble mausoleum on the right bank of the river Yamuna in Agra, Uttar Pradesh, India. It was commissioned in 1631 by the fifth Mughal emperor, Shah Jahan to house the tomb of his favourite wife, Mumtaz Mahal; it also houses the tomb of Shah Jahan himself.',
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w400, height: 1.9),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(60, 50),
                  backgroundColor: Colors.teal.shade700),
              onPressed: () {},
              child: const Text(
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
    const Taj(imageUrl: 'lib/assets/TajMahal-1.jpg'),
    const Taj(imageUrl: 'lib/assets/TajMahal-2.jpg'),
    const Taj(imageUrl: 'lib/assets/Taj-Mahal-3.jpg'),
    // const Kolukku(imageUrl: 'lib/assets/kolukku-5.jpg'),
    const Taj(imageUrl: 'lib/assets/Taj-mahal-4.jpg')
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
