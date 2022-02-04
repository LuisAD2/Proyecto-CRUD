import 'package:equipos_app/ui/inicial_page.dart';
import 'package:flutter/material.dart';
//Clase main que inicializa la app

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'equipos_app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: InicialPage(),//ira a nuestra pantalla inicial
    );
  }
}