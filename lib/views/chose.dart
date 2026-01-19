import 'package:flutter/material.dart';
import '../data/producto_data.dart';
import '../views/appColors.dart';
import '../viewmodels/choseViewmodel.dart';

/// Vista para seleccionar productos
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
      body: Column(
        children: [
          // --- LISTA DE PRODUCTOS DISPONIBLES ---
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
                    double borderWidth = 0.0;
                    if (isSelected) {
                      borderColor = AppColors.secundarioOscuro; 
                      borderWidth = 3.0;
                    } else if (hasItems) {
                      borderColor = AppColors.principalOscuro; 
                      borderWidth = 2.0;
                    }

                    return Card(
                      color: AppColors.neutroClaro.withAlpha(220),
                      elevation: isSelected ? 6 : 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide(color: borderColor, width: borderWidth),
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
                                        fontSize: 20,
                                        color: isSelected
                                            ? AppColors.principal
                                            : AppColors.secundario,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${producto.precio.toStringAsFixed(2)} €",
                                      style: const TextStyle(
                                          color: AppColors.neutroOscuro, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),

                              // --- DERECHA: ESTADO DEL PRODUCTO ---
                              if (isSelected)
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        iconSize: 20,
                                        icon: const Icon(Icons.remove,
                                            color: AppColors.principalOscuro),
                                        onPressed: () => viewModel.Decrease(producto),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(), 
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                        child: Text(
                                          cantidad.toString(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.neutroOscuro),
                                        ),
                                      ),
                                      IconButton(
                                        iconSize: 20,
                                        icon: const Icon(Icons.add, color: AppColors.secundario),
                                        onPressed: () => viewModel.Increase(producto),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                    ],
                                  ),
                                )
                              else if (hasItems)
                                // --- ESTADO: CON CANTIDAD (NO SELECCIONADO) ---
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  child: Text(
                                    "$cantidad uds.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold, 
                                      color: AppColors.principalOscuro,
                                      fontSize: 14
                                    ),
                                  ),
                                )
                              else
                                // --- ESTADO: NEUTRO (SIN CANTIDAD) ---
                                const Icon(Icons.touch_app_outlined,
                                    color: AppColors.secundarioClaro),
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
          
          // --- BOTONERA INFERIOR ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.neutroOscuro.withOpacity(0),
              boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: const Color(0xFF41443E),
                    ),
                    child: const Text("Cancelar",
                        style: TextStyle(color: AppColors.neutroClaro)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: AppColors.secundario,
                    ),
                    child: const Text("Confirmar selección",
                        style: TextStyle(color: AppColors.neutroClaro)),
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