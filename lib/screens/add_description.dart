import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddDescription extends StatefulWidget {
  const AddDescription({super.key});

  @override
  State<AddDescription> createState() => _AddDescriptionState();
}

class _AddDescriptionState extends State<AddDescription> {
  final TextEditingController _descController = TextEditingController();


  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String thisOwnerId = user!.uid;
    
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
          title: const Text('Campaign Details'),
        ),
        body: Container(
          


        ),

      
    );
  }
}

