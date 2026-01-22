import 'package:flutter/material.dart';
import '../viewmodels/homeViewmodel.dart';
import '../models/pedido.dart';
import '../views/newOrder.dart';
import '../views/appColors.dart';

/// Vista principal de la aplicación
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
      body: SafeArea(
        child: Column(
        children: [
          // --- TÍTULO ---
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

          // --- LISTA DE PEDIDOS ---
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
                      color: AppColors.neutroClaro.withAlpha(220),
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
                            color: AppColors.neutroOscuro)
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

          // --- BOTÓN NUEVO PEDIDO ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secundario,
                padding: const EdgeInsets.symmetric(
                  horizontal: 48, 
                  vertical: 16,   
                )),
              child: Text("Nuevo Pedido",
              style: TextStyle(
                color: AppColors.neutroClaro,
                fontSize: 16
              ),
              ),
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
      ),
    );
  }
}
