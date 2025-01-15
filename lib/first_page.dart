import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:ifmd_app/constants/grid_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final urlImages = [
      'https://pbs.twimg.com/media/GcRQKosWsAARzSE?format=jpg&name=large',
      'https://pbs.twimg.com/media/GhKYp8vW4AAGnrS?format=jpg&name=large',
      'https://pbs.twimg.com/media/Ge_aEhgW0AAtgYY?format=jpg&name=large'
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: urlImages.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = urlImages[index];
                return buildImage(urlImage);
              },
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Derneğimiz",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Expanded(child: GridViewWidget()),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String urlImage) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
      );
}
