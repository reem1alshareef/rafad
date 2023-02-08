import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
 
  // the values we need
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard(
      {required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 17),
        child: ListTile(
          leading: Icon(
            icon,
            color: Color.fromARGB(255, 124, 174, 228),
          ),
          title: Text(
            text,
            style: TextStyle(
                color: Color.fromARGB(255, 1, 21, 59),
                fontSize: 14,
                fontFamily: "Source Sans Pro"),
          ),
        ),
      ),
    );
  }
}