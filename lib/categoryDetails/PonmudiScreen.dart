import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equatable/equatable.dart';

class PonmudiScreen extends StatefulWidget {
  //const PonmudiScreen({super.key});
  final int intemIndex1;
  PonmudiScreen({required this.intemIndex1});

  @override
  State<PonmudiScreen> createState() => _PonmudiScreenState();
}

class _PonmudiScreenState extends State<PonmudiScreen> {
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
                  'Ponmudi hills',
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
              items: Ponmudi.categories
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
                'Locals in the capital city of Thiruvananthapuram will declare that a weekend drive to Ponmudi is among the best ways to spend time in the city. Families and friends alike are known to go on long drives up the winding paths for a view they insist rivals any other in the State. The slopes shrouded in mist fill one with a feeling of wonder and amazement. A large amount of rare flora and fauna can be seen here including mountain flowers, wild orchids and exotic butterflies',
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

class Ponmudi extends Equatable {
  final String imageUrl;
  const Ponmudi({
    required this.imageUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [imageUrl];
  static List<Ponmudi> categories = [
    const Ponmudi(imageUrl: 'lib/assets/ponmudi-1.jpg'),
    const Ponmudi(imageUrl: 'lib/assets/ponmudi-2.jpg'),
    const Ponmudi(imageUrl: 'lib/assets/ponmudi-3.jpg'),
    // const Kolukku(imageUrl: 'lib/assets/kolukku-5.jpg'),
    const Ponmudi(imageUrl: 'lib/assets/ponmudi-4.jpg')
  ];
}

class HeroCarouselCard extends StatelessWidget {
  final Ponmudi category;
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
