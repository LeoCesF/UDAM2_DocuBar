import 'package:flutter/material.dart';
import '../viewmodels/newOrderViewmodel.dart';
import '../models/lineaPedido.dart';
import '../views/chose.dart';

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final NewOrderViewModel viewModel = NewOrderViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Nuevo Pedido')),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          return Column(
            children: [
              // --- SECCIÓN MESA ---
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: "Mesa o Nombre",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.table_restaurant),
                  ),
                  onChanged: (texto) {
                    viewModel.setMesa(texto);
                  },
                ),
              ),

              // --- SECCIÓN LISTA PROVISIONAL ---
              Expanded(
                child: viewModel.lineas.isEmpty
                    ? const Center(
                        child: Text("No hay productos seleccionados"),
                      )
                    : ListView.builder(
                        itemCount: viewModel.lineas.length,
                        itemBuilder: (context, index) {
                          final linea = viewModel.lineas[index];
                          return ListTile(
                            title: Text(linea.producto.nombre),
                            subtitle: Text("x${linea.cantidad} un."),
                            trailing: Text(
                              "${linea.subtotal.toStringAsFixed(2)} €",
                            ),
                          );
                        },
                      ),
              ),

              const Divider(thickness: 2),

              // --- TOTAL ACUMULADO ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total estimado:",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "${viewModel.total.toStringAsFixed(2)} €",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // --- BOTONERA ---
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Botón 1: Ir a elegir productos
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text("Añadir Productos"),
                        onPressed: () async {
                          // REQUISITO: Navegación push esperando resultado
                          // Nota: Asumimos que ChoosePage devolverá List<LineaPedido>
                          // (Areglaremos ChoosePage en el siguiente paso)
                          final resultado = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChoosePage(),
                            ),
                          );

                          if (!mounted) return;

                          if (resultado != null &&
                              resultado is List<LineaPedido>) {
                            viewModel.agregarLineas(resultado);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Botón 2: Ver Resumen (Navegación con nombre)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: viewModel.lineas.isNotEmpty
                            ? () {
                                // REQUISITO: Navegación con rutas nombradas
                                // Pasamos el pedido actual como argumento
                                Navigator.pushNamed(
                                  context,
                                  '/resumen',
                                  arguments: viewModel.crearPedidoFinal(),
                                );
                              }
                            : null,
                        child: const Text(
                          "Ver Resumen",
                        ), // Desactivado si no hay productos
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Botones Guardar / Cancelar
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            child: const Text(
                              "Cancelar",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              // REQUISITO: Pop sin devolver nada
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            // REQUISITO: Deshabilitado si no es válido
                            onPressed: viewModel.esValido
                                ? () {
                                    // REQUISITO: Pop devolviendo el Pedido completo
                                    Navigator.pop(
                                      context,
                                      viewModel.crearPedidoFinal(),
                                    );
                                  }
                                : null,
                            child: const Text(
                              "Guardar Pedido",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
