import 'package:flutter/material.dart';
import '../data/producto_data.dart';
import '../viewmodels/choseViewmodel.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  final ChooseViewModel viewModel = ChooseViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Carta de Productos')),
      body: Column(
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: viewModel,
              builder: (context, child) {
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: ProductoData.productos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final producto = ProductoData.productos[index];
                    final cantidad = viewModel.getCantidad(producto);
                    final bool isSelected = viewModel.isSelected(producto);
                    final bool hasItems = cantidad > 0;

                    // LÓGICA DE COLORES DEL BORDE
                    Color borderColor = Colors.transparent;
                    if (isSelected) {
                      borderColor = Colors.blue; // Azul si lo estás tocando
                    } else if (hasItems) {
                      borderColor = Colors.green; // Verde si ya tiene productos
                    }

                    return Card(
                      elevation: isSelected ? 6 : 2,
                      // Borde condicional
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: borderColor,
                          width: (isSelected || hasItems) ? 2.0 : 0.0,
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => viewModel.SelectProduct(producto),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                          child: Row(
                            children: [
                              // --- IZQUIERDA: INFORMACIÓN ---
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      producto.nombre,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        // Texto azul si está seleccionado, verde si añadido, negro normal
                                        color: isSelected 
                                            ? Colors.blue 
                                            : (hasItems ? Colors.green[700] : Colors.black),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${producto.precio.toStringAsFixed(2)} €",
                                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),

                              // --- DERECHA: CONTROLES EN LÍNEA ---
                              if (isSelected)
                                // ESTADO EDITANDO: Botones en línea
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        iconSize: 20,
                                        icon: const Icon(Icons.remove, color: Colors.red),
                                        onPressed: () => viewModel.Decrease(producto),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(), // Hace el botón compacto
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                        child: Text(
                                          cantidad.toString(),
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      IconButton(
                                        iconSize: 20,
                                        icon: const Icon(Icons.add, color: Colors.green),
                                        onPressed: () => viewModel.Increase(producto),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                    ],
                                  ),
                                )
                              else if (hasItems)
                                // ESTADO NO SELECCIONADO PERO CON CANTIDAD: Badge verde
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.green),
                                  ),
                                  child: Text(
                                    "$cantidad uds.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold, 
                                      color: Colors.green[800],
                                      fontSize: 14
                                    ),
                                  ),
                                )
                              else
                                // ESTADO NEUTRO (Opcional: Icono para invitar a pulsar)
                                Icon(Icons.add_circle_outline, color: Colors.grey[300]),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          
          // BOTONERA INFERIOR (Sin cambios)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16)),
                    child: const Text("Cancelar"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                    child: const Text("Confirmar selección"),
                    onPressed: () {
                      final seleccion = viewModel.getSelection();
                      Navigator.pop(context, seleccion);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}