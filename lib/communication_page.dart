import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommunicationPage extends StatefulWidget {
  const CommunicationPage({super.key});

  @override
  State<CommunicationPage> createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Fatihistanbul.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('İletişim Sayfası'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // İsim Alanı
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'İsim',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen isminizi girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Soyisim Alanı
                  TextFormField(
                    controller: _surnameController,
                    decoration: const InputDecoration(
                      labelText: 'Soyisim',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen soyisminizi girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Email Alanı
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-posta',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen e-posta adresinizi girin';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Lütfen geçerli bir e-posta adresi girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Mesaj Alanı
                  TextFormField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 30,
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen bir mesaj girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Gönder Butonu
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 201, 173, 171),
                    ),
                    onPressed: () async {
                      final addData = AddDataFireStore();
                      if (_formKey.currentState!.validate()) {
                        bool success = await addData.addResponse(
                          _nameController.text,
                          _surnameController.text,
                          _emailController.text,
                          _messageController.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              success
                                  ? "Mesaj başarıyla gönderildi!"
                                  : "Mesaj gönderilemedi",
                            ),
                          ),
                        );
                        if (success) {
                          _formKey.currentState!.reset();
                        }
                      }
                    },
                    child: const Text('Gönder'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddDataFireStore {
  CollectionReference response =
      FirebaseFirestore.instance.collection("Communucation");

  Future<bool> addResponse(
      final ad, final soyad, final email, final mesaj) async {
    try {
      await response.add({
        "ad": ad,
        "soyad": soyad,
        "email": email,
        "mesaj": mesaj,
      });
      print("Veri eklendi");
      return true;
    } catch (e) {
      print("Veri eklenirken hata oluştu: $e");
      return false;
    }
  }
}
