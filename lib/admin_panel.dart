import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Fatihistanbul.jpg', // Arka plan resminizin yolu
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  centerTitle: true,
                  title: const Text('Blog Panel İşlemleri'),
                  backgroundColor:
                      Colors.black.withOpacity(0.5), // Hafif opaklık
                  elevation: 0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildTextFormField(
                              _titleController, 'Başlık', 'Enter title here'),
                          const SizedBox(height: 20),
                          _buildTextFormField(
                              _bodyController, 'İçerik', 'İçeriğinizi yazın',
                              maxLines: 5),
                          const SizedBox(height: 20),
                          _buildTextFormField(
                              _dateController, 'Tarih', 'Tarih girin'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                await FirebaseFirestore.instance
                                    .collection("Events")
                                    .add({
                                  "title": _titleController.text,
                                  "description": _bodyController.text,
                                  "date": _dateController.text,
                                  "created_at": FieldValue
                                      .serverTimestamp(), // Zaman damgası ekliyoruz
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Veri başarıyla kaydedildi")),
                                );

                                // Formu temizle
                                _titleController.clear();
                                _bodyController.clear();
                                _dateController.clear();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Hata oluştu: $e")),
                                );
                              }
                            },
                            child: const Text("Kaydet"),
                          ),
                          const SizedBox(height: 30),
                          // Liste
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("Events")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final events = snapshot.data!.docs;
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: events.length,
                                itemBuilder: (context, index) {
                                  final event = events[index];
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        event['title'] ?? 'Başlık Yok',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            event['description'] ??
                                                'Açıklama Yok',
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            event['date'] ?? 'Tarih Yok',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {
                                              _titleController.text =
                                                  event['title'] ?? '';
                                              _bodyController.text =
                                                  event['description'] ?? '';
                                              _dateController.text =
                                                  event['date'] ?? '';
                                              _showDialog(
                                                  context,
                                                  event
                                                      .id); // Düzenleme işlemi için dialog
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              _deleteEvent(
                                                  event.id); // Silme işlemi
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String label, String hint,
      {int maxLines = 1}) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void _deleteEvent(String id) async {
    try {
      await FirebaseFirestore.instance.collection("Events").doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veri başarıyla silindi")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hata oluştu: $e")),
      );
    }
  }

  void _showDialog(BuildContext context, String eventId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Düzenle"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextFormField(
                  _titleController, 'Başlık', 'Yeni başlık girin'),
              const SizedBox(height: 10),
              _buildTextFormField(
                  _bodyController, 'İçerik', 'Yeni içerik girin',
                  maxLines: 5),
              const SizedBox(height: 10),
              _buildTextFormField(_dateController, 'Tarih', 'Yeni tarih girin'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("İptal"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection("Events")
                      .doc(eventId)
                      .update({
                    "title": _titleController.text,
                    "description": _bodyController.text,
                    "date": _dateController.text,
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Veri başarıyla güncellendi")),
                  );
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Hata oluştu: $e")),
                  );
                }
              },
              child: const Text("Kaydet"),
            ),
          ],
        );
      },
    );
  }
}
