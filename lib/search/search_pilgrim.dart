import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class SearchPilgrim extends StatefulWidget {
  const SearchPilgrim({super.key});

  @override
  State<SearchPilgrim> createState() => _SearchPilgrimState();
}

class _SearchPilgrimState extends State<SearchPilgrim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
          actions: const [
            SizedBox(height: 30),
          ],
        ),
    );
  }
}