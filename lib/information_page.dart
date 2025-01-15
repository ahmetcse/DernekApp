import 'package:flutter/material.dart';
import 'package:ifmd_app/constants/common_appbar.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          title: "Info Page", onProfileTap: () {}, onSettingsTap: () {}),
    );
  }
}
