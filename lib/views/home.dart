import 'package:flutter/material.dart';
import '../viewmodels/homeViewmodel';
import '../models/pedido.dart';
import '../views/newOrder.dart';
import '../views/appColors.dart';

class HomePage extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomePage({super.key, required this.viewModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Lista de pedidos:", 
              style: 
              TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                fontStyle: FontStyle.italic,
                color: AppColors.secundarioClaro, 
                decoration: TextDecoration.underline, 
                decorationColor: AppColors.secundarioClaro)),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: widget.viewModel,
              builder: (context, child) {
                if (widget.viewModel.pedidos.isEmpty) {
                  return const Center(
                    child: Text("No hay pedidos activos"));
                }
                return ListView.builder(
                  itemCount: widget.viewModel.pedidos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final pedido = widget.viewModel.pedidos[index];
                    return Card(
                      color: AppColors.neutroClaro.withAlpha(200),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: const BorderSide(
                            color: AppColors.principalOscuro, width: 1),
                      ),
                      child: ListTile(
                        title: Text(
                          "Mesa: ${pedido.mesa}", 
                          style: const TextStyle(
                            fontSize: 20, 
                            color: AppColors.secundario)),
                        subtitle: Text(
                          "Productos: ${pedido.totalProductos}",
                          style: const TextStyle(
                            fontSize: 12, 
                            color: AppColors.secundario)
                          ),
                        trailing: Text(
                          "${pedido.total.toStringAsFixed(2)} €", 
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: 16,
                              color: AppColors.secundario
                            )
                          ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              // Aumentamos el padding interno para hacer el botón más grande
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32, // Más ancho
                  vertical: 16,   // Más alto
                ),
              ),
              child: const Text("Nuevo Pedido"),
              onPressed: () async {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewOrder()), 
                );
                if (!mounted) return;

                if (resultado != null && resultado is Pedido) {
                  widget.viewModel.agregarPedido(resultado);
                }
              },
            ),
          ),   
        ],
      ),
    );
  }
}
