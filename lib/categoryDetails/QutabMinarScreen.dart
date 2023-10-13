import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equatable/equatable.dart';

class QutabMinarScreen extends StatefulWidget {
  // const QutabMinarScreen({super.key});
  final int itemIndex;
  QutabMinarScreen({required this.itemIndex});

  @override
  State<QutabMinarScreen> createState() => _QutabMinarScreenState();
}

class _QutabMinarScreenState extends State<QutabMinarScreen> {
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
                  'Qutab Minar',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  width: 120,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline),
                )
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
              items: Qutab.categories
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
                'The Qutb Minar, also spelled Qutub Minar and Qutab Minar, is a minaret and "victory tower" that forms part of the Qutb complex, which lies at the site of Delhi’s oldest fortified city, Lal Kot, founded by the Tomar Rajputs. It is a UNESCO World Heritage Site in the Mehrauli area of South Delhi, India',
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

class Qutab extends Equatable {
  final String imageUrl;
  const Qutab({
    required this.imageUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [imageUrl];
  static List<Qutab> categories = [
    const Qutab(imageUrl: 'lib/assets/qutabMinar-1.jpg'),
    const Qutab(imageUrl: 'lib/assets/QutabMinar-2.jpeg'),
    const Qutab(imageUrl: 'lib/assets/Qutab-Minar-3.jpg'),
    // const Kolukku(imageUrl: 'lib/assets/kolukku-5.jpg'),
    const Qutab(imageUrl: 'lib/assets/Qutabminar-4.jpg')
  ];
}

class HeroCarouselCard extends StatelessWidget {
  final Qutab category;
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
