import 'package:app/views/appColors.dart';
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
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          return Column(
            children: [
              // --- CAMPO NÚMERO DE MESA ---
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  style: const TextStyle(color: AppColors.neutroClaro),
                  cursorColor: AppColors.neutroClaro,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.5),
                    labelText: "Numero de mesa:",
                    labelStyle: const TextStyle(color: AppColors.neutroClaro),
                    prefixIcon: const Icon(Icons.table_restaurant),
                    prefixIconColor: AppColors.neutroClaro,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.neutroClaro),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.neutroClaro, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                  onChanged: (texto) {
                    viewModel.setMesa(texto);
                  },
                ),
              ),

              // --- LISTA DE PRODUCTOS SELECCIONADOS ---
              Expanded(
                child: viewModel.lineas.isEmpty
                    ? const Center(
                        child: Text("No hay productos seleccionados",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.neutroClaro
                        ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: viewModel.lineas.length,
                        itemBuilder: (context, index) {
                          final linea = viewModel.lineas[index];
                          return Card(
                            color: AppColors.neutroClaro.withAlpha(220),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: const BorderSide(
                                  color: AppColors.principalOscuro, width: 1),
                            ),
                            child: ListTile(
                              title: Text(linea.producto.nombre,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: AppColors.secundario)),
                              subtitle: Text("x${linea.cantidad} un.",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.neutroOscuro)),
                              trailing: Text(
                                "${linea.subtotal.toStringAsFixed(2)} €",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppColors.secundario),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const Divider(thickness: 2),

              // --- TOTAL ESTIMADO ---
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                        color: AppColors.secundarioClaro
                        ),
                    ),
                    Text(
                      "${viewModel.total.toStringAsFixed(2)} €",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secundarioClaro
                      ),
                    ),
                  ],
                ),
              ),

              // --- BOTONERA DE ACCIONES ---
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // --- BOTÓN AÑADIR PRODUCTOS ---
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.principalClaro,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 16,
                            )),
                        icon: const Icon(Icons.add_shopping_cart,
                            color: AppColors.neutroOscuro),
                        label: const Text("Añadir Productos",
                            style: TextStyle(color: AppColors.neutroOscuro)),
                        onPressed: () async {
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

                    // --- BOTÓN VER RESUMEN ---
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.principal,
                        ),
                        onPressed: viewModel.lineas.isNotEmpty
                            ? () {
                                Navigator.pushNamed(
                                  context,
                                  '/resumen',
                                  arguments: viewModel.crearPedidoFinal(),
                                );
                              }
                            : null,
                        child: const Text(
                          "Ver Resumen",
                          style: TextStyle(color: AppColors.neutroClaro),
                        ), 
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- BOTONES GUARDAR / CANCELAR ---
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF41443E),
                            ),
                            child: const Text(
                              "Cancelar",
                              style: TextStyle(color: AppColors.neutroClaro),
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
                              backgroundColor: AppColors.secundario,
                            ),
                            onPressed: viewModel.esValido
                                ? () {
                                    Navigator.pop(
                                      context,
                                      viewModel.crearPedidoFinal(),
                                    );
                                  }
                                : null,
                            child: const Text(
                              "Guardar Pedido",
                              style: TextStyle(color: AppColors.neutroClaro),
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
