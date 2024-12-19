import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  // Run the app after Firebase initialization
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseTestPage(),
    );
  }
}

class FirebaseTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Test")),
      body: Center(
        child: FutureBuilder(
          future: Firebase.initializeApp(), // Initialize Firebase
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text("Firebase connected successfully!");
            }
            if (snapshot.hasError) {
              return Text("Error initializing Firebase: ${snapshot.error}");
            }
            return CircularProgressIndicator(); // Show a loading indicator while waiting
          },
        ),
      ),
    );
  }
}
