import 'package:flutter/material.dart';
import '../viewmodels/homeViewmodel';
import '../models/pedido.dart';
import 'newOrder.dart';

class HomePage extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomePage({super.key, required this.viewModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Usamos widget.viewModel para acceder al viewModel
    return Scaffold(
      appBar: AppBar(title: const Text('Bar - Pedidos')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Lista de pedidos:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            // Aquí la magia del MVVM: AnimatedBuilder escucha cambios
            child: AnimatedBuilder(
              animation: widget.viewModel,
              builder: (context, child) {
                // Si la lista está vacía
                if (widget.viewModel.pedidos.isEmpty) {
                  return const Center(child: Text("No hay pedidos activos"));
                }

                return ListView.builder(
                  itemCount: widget.viewModel.pedidos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final pedido = widget.viewModel.pedidos[index];
                    return Card(
                      child: ListTile(
                        title: Text("Mesa: ${pedido.mesa}"),
                        subtitle: Text("Productos: ${pedido.totalProductos}"),
                        trailing: Text("${pedido.total.toStringAsFixed(2)} €", 
                                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
              child: const Text("Nuevo pedido"),
              onPressed: () async {
                // REQUISITO: Navegación imperativa con push esperando resultado
                // NOTA: Aun no hemos arreglado NewOrder para recibir el VM, 
                // pero dejaremos la estructura lista.
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewOrder()), 
                );

                // REQUISITO: Comprobar mounted y si hay resultado
                if (!mounted) return;

                if (resultado != null && resultado is Pedido) {
                  // Si volvimos con un pedido, lo añadimos al VM
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
