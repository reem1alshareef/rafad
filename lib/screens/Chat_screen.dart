import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Chat_screen extends StatefulWidget {
  const Chat_screen({super.key});

  @override
  State<Chat_screen> createState() => _Chat_screenState();
}

class _Chat_screenState extends State<Chat_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF455D83),
      title: Row(children: [Icon((Icons.messenger_outlined)), Text(' Chat'),],),
      actions: [IconButton(onPressed: (){Navigator.of(
                                                                      context)
                                                                  .pop();}, icon: Icon((Icons.close)),)]));
  }
}