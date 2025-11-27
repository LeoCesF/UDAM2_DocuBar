import 'package:app/viewmodels/homeViewmodel';
import 'package:flutter/material.dart';
import '../views/home.dart';
import '../views/summary.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Creamos el ViewModel principal
    final homeViewModel = HomeViewModel();

    return MaterialApp(
      title: 'Registro del bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Un poco de estilo global para que se vea mejor
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      // REQUISITO: Definir rutas con nombre
      routes: {
        '/resumen': (context) => const SummaryPage(),
        // Las otras rutas no son estrictamente necesarias aquí si usas 
        // navegación imperativa (push directo) para Home->NewOrder y NewOrder->Choose,
        // pero puedes dejarlas si quieres. El requisito estricto de named route es para el resumen.
      },
      // Pantalla inicial
      home: HomePage(viewModel: homeViewModel),
    );
  }
}