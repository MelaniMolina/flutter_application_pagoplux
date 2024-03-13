import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  // Usa las opciones según la plataforma actual
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        // Simula una carga o espera de 2 segundos antes de decidir qué pantalla mostrar
        future: Future.delayed(Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Después de 2 segundos, muestra la pantalla MainScreen
            return HomeScreen();
          } else {
            // Mientras tanto, muestra la pantalla SplashScreen
            return SplashScreen();
          }
        },
      ),
    );
  }
}
