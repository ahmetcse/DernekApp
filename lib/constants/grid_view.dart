import 'package:flutter/material.dart';
import 'package:ifmd_app/communication_page.dart';
import 'package:ifmd_app/events_page.dart';
import 'package:ifmd_app/models/card_models.dart';
import 'package:ifmd_app/survey_page.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Card'lar için veri listesi
    List<CardItem> cardItems = [
      CardItem(
        title: ' Etkinlikler',
        icon: Icons.event, // Örnek icon
        page: const EventsPage(),
      ),
      CardItem(
        title: 'Kurslar',
        icon: Icons.school, // Örnek icon
        page: const EventsPage(),
      ),
      CardItem(
        title: 'Yayınlar',
        icon: Icons.newspaper, // Örnek icon
        page: const EventsPage(),
      ),
      CardItem(
        title: 'İlanlar',
        icon: Icons.shopping_bag, // Örnek icon
        page: const EventsPage(),
      ),
      CardItem(
        title: 'Anket',
        icon: Icons.poll, // Örnek icon
        page: const SurveyPage(),
      ),
      CardItem(
        title: 'Destek',
        icon: Icons.email, // Örnek icon
        page: const CommunicationPage(),
      ),
    ];

    return GridView.builder(
      shrinkWrap:
          true, // GridView'in yüksekliği, ekranın geri kalan kısmına uyacak şekilde ayarlanacak
      physics:
          const NeverScrollableScrollPhysics(), // GridView kaydırma etkisini devre dışı bırak
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 sütun
        crossAxisSpacing: 10, // Sütunlar arasındaki boşluk
        mainAxisSpacing: 10, // Satırlar arasındaki boşluk
        childAspectRatio: 0.7, // Card'ların en-boy oranı
      ),
      itemCount: cardItems.length, // Liste uzunluğuna göre item count
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => cardItems[index].page,
              ),
            );
          },
          child: Card(
            elevation: 4, // Card'a gölge efekti
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Köşe yuvarlama
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    cardItems[index].icon, // Her card için farklı ikon
                    size: 40,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Text(
                    cardItems[index].title, // Her card için farklı başlık
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
