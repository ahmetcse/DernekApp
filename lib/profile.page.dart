import 'package:flutter/material.dart';
import 'package:ifmd_app/service/auth.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    final String? displayName = auth.userName;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(
                  "Hos geldin $displayName",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/images/png-transparent-computer-icons-avatar-user-profile-avatar-heroes-rectangle-black-thumbnail.png",
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: "Email Adres",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: "Şifre ",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock)),
                ),
              ])),
        ),
      ),
    );
  }
}
