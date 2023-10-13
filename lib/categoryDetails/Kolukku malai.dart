import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equatable/equatable.dart';

class KolukkuMalaiScreen extends StatefulWidget {
  //const KolukkuMalaiScreen({super.key});
  final int itemIndex1;
  KolukkuMalaiScreen({required this.itemIndex1});

  @override
  State<KolukkuMalaiScreen> createState() => _KolukkuMalaiScreenState();
}

class _KolukkuMalaiScreenState extends State<KolukkuMalaiScreen> {
  List<bool> favorites = List.generate(5, (_) => false);

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
                'Kolukku malai peak',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                width: 20,
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
            items: Kolukku.categories
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
              'Kolukkumalai is the world’s highest elevation tea plantation at 7900 feet msl. Kolukkumalai is without argument one of the world’s most beautiful scenic destinations. Started in the early 1900s the estate produces tea using the orthodox method in the time-tested tea factory.',
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
    ));
  }
}

class Kolukku extends Equatable {
  final String imageUrl;
  const Kolukku({
    required this.imageUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [imageUrl];
  static List<Kolukku> categories = [
    const Kolukku(imageUrl: 'lib/assets/kokukku-1.jpg'),
    const Kolukku(imageUrl: 'lib/assets/kolukku-2.jpg'),
    const Kolukku(imageUrl: 'lib/assets/kolukku-3.jpg'),
    // const Kolukku(imageUrl: 'lib/assets/kolukku-5.jpg'),
    const Kolukku(imageUrl: 'lib/assets/kolukku-5.jpg')
  ];
}

class HeroCarouselCard extends StatelessWidget {
  final Kolukku category;
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
