import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Büyük "Settings" başlığı
          const Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {}, // Tıklanabilir ama işlevsellik yok
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start, // Yazıyı sola hizalar
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.crop, // Simge
                      color: Colors.white, // Simge rengi
                    ),
                    Text(
                      '   ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Yazı rengi beyaz
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: 'General'),
          SettingsItem(
            icon: Icons.description,
            title: 'Terms of Service',
            onTap: () {}, // Tıklanabilir ama yönlendirme yok
          ),
          SettingsItem(
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            onTap: () {}, // Tıklanabilir ama yönlendirme yok
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: 'Feedback'),
          SettingsItem(
            icon: Icons.star_rate,
            title: 'Rate the App',
            onTap: () {}, // Tıklanabilir ama yönlendirme yok
          ),
          SettingsItem(
            icon: Icons.rate_review,
            title: 'Write a Review',
            onTap: () {}, // Tıklanabilir ama yönlendirme yok
          ),
          SettingsItem(
            icon: Icons.share,
            title: 'Share the App',
            onTap: () {}, // Tıklanabilir ama yönlendirme yok
          ),
          const SizedBox(height: 16),
          const SectionHeader(title: 'Account'),
          SettingsItem(
            icon: Icons.mail,
            title: 'Contact Support',
            onTap: () {}, // Tıklanabilir ama yönlendirme yok
          ),
          SettingsItem(
            icon: Icons.restore,
            title: 'Restore Purchases',
            onTap: () {}, // Tıklanabilir ama yönlendirme yok
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap; // Tıklama işlevi

  const SettingsItem({
    required this.icon,
    required this.title,
    this.onTap, // Tıklama işlevi opsiyonel
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Tıklanabilir ama işlem yok
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.teal),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
