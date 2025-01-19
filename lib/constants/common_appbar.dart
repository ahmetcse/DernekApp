import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onProfileTap;
  final VoidCallback onSettingsTap;

  const CommonAppBar({
    super.key,
    required this.title,
    required this.onProfileTap,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Arka plan resmi
        Positioned.fill(
          child: Image.asset(
            'assets/images/Fatihistanbul.jpg', // Resim dosyasının yolu
            fit: BoxFit.cover,
          ),
        ),
        // Üst katmanda AppBar içeriği
        AppBar(
          backgroundColor: Colors.transparent, // Şeffaf AppBar
          elevation: 0, // Gölgeyi kaldır
          leading: Navigator.canPop(context)
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
          title: Text(
            title,
            style:
                const TextStyle(color: Colors.white), // Yazı rengini beyaz yap
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: onSettingsTap,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
