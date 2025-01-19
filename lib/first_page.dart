import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter/material.dart';

import 'package:ifmd_app/constants/grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final urlImages = [
      'https://pbs.twimg.com/media/GcRQKosWsAARzSE?format=jpg&name=large',
      'https://pbs.twimg.com/media/GhKYp8vW4AAGnrS?format=jpg&name=large',
      'https://pbs.twimg.com/media/Ge_aEhgW0AAtgYY?format=jpg&name=large'
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          FlutterCarousel(
            items: urlImages.map((urlImage) => buildImage(urlImage)).toList(),
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enableInfiniteScroll: true,
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
    );
  }

  Widget buildImage(String urlImage) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: Colors.grey[300],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      );
}
