import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class ScreenDetail extends StatefulWidget {
  const ScreenDetail({super.key, required this.access});
  final Map<String, dynamic> access;

  @override
  State<ScreenDetail> createState() => _ScreenDetailState();
}

class _ScreenDetailState extends State<ScreenDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 25,
                ),
                Text(
                  widget.access['title'] ?? 'title not available',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 250,
              width: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.access['image']),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(widget.access['description']),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(60, 50),
                  backgroundColor: Colors.teal.shade700),
              onPressed: () {
                directionMapUrl(widget.access['location']);
              },
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

Future<void> directionMapUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}
