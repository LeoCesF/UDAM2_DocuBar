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
    final homeViewModel = HomeViewModel();

    return MaterialApp(
      title: 'Registro del bar',
      // --- TEMA DE LA APLICACIÓN ---
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 20, 18, 4)),
        useMaterial3: true, 
        canvasColor: Colors.transparent,
      ),
      routes: {
        '/resumen': (context) => const SummaryPage(),
      },
      home: HomePage(viewModel: homeViewModel),
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fondo_app.jpg'), 
              fit: BoxFit.cover,
              // Ajusta este valor entre 0.0 (transparente) y 1.0 (opaco)
              opacity: 0.8,
            ),
          ),
          child: child,
        );
      },
    );
  }
}