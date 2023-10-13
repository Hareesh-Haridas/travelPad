import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equatable/equatable.dart';

class GoaScreen extends StatefulWidget {
  // const GoaScreen({super.key});
  final int itemIndex;
  GoaScreen({required this.itemIndex});

  @override
  State<GoaScreen> createState() => _GoaScreenState();
}

class _GoaScreenState extends State<GoaScreen> {
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
                  'Goa beaches',
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
              items: IndiaGate.categories
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
                'Goa is a state in western India with coastlines stretching along the Arabian Sea. Its long history as a Portuguese colony prior to 1961 is evident in its preserved 17th-century churches and the area’s tropical spice plantations.',
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

class IndiaGate extends Equatable {
  final String imageUrl;
  const IndiaGate({
    required this.imageUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [imageUrl];
  static List<IndiaGate> categories = [
    const IndiaGate(imageUrl: 'lib/assets/goa.jpg'),
    const IndiaGate(imageUrl: 'lib/assets/goa 2.jpg'),
    const IndiaGate(imageUrl: 'lib/assets/Goa-3.jpg'),
    // const Kolukku(imageUrl: 'lib/assets/kolukku-5.jpg'),
    const IndiaGate(imageUrl: 'lib/assets/goa-4.jpg')
  ];
}

class HeroCarouselCard extends StatelessWidget {
  final IndiaGate category;
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
