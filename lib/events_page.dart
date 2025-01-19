import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etkinlikler'),
        backgroundColor: Colors.grey[300], // AppBar'ın şeffaf olması için
        elevation: 0, // AppBar'ın gölgesini kaldır
      ),
      body: Stack(
        children: [
          // Sayfa arka plan resmi
          Positioned.fill(
            child: Image.asset(
              'assets/images/Fatihistanbul.jpg', // Aynı resim sayfa ve AppBar için
              fit: BoxFit.cover,
            ),
          ),
          // Sayfa içeriği
          Padding(
            padding: const EdgeInsets.only(
                top: 80), // AppBar yüksekliği kadar boşluk bırakıyoruz
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("Events").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Bir hata oluştu.'),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('Hiç etkinlik bulunamadı.'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    return Card(
                      color: Colors.grey[300],
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              documentSnapshot["title"] ?? "Başlık yok",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              documentSnapshot["description"] ?? "Açıklama yok",
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              documentSnapshot["date"] ?? "Açıklama yok",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
