import 'package:flutter/material.dart';
import 'package:rafad1/screens/navigation_screen.dart';

class MyApp2 extends StatefulWidget {
  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Enter your location',
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: latController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'latitude',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: lngController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'longitute',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NavigationScreen(
                          double.parse(latController.text),
                          double.parse(lngController.text))));
                },
                child: Text('Get Directions')),
          ),
        ]),
      ),
    );
  }
}
