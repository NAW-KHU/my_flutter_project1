// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  String title;

  HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'welcome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
