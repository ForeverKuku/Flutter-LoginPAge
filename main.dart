import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_bonnah/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.active) {
                    User? user = snapshot.data;

                    if (user == null) {
                      return Login();
                    } else {
                      return const Scaffold(
                        body: Center(
                          child: Text("Checking Login Auth...."),
                        ),
                      );
                    }
                  }
                
                });
          }
          return const Scaffold(
            body: Center(
              child: Text("Connecting to the App...."),
            ),
          );
        });
  }
}
