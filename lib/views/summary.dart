import 'package:flutter/material.dart';
import '../models/pedido.dart';
import 'appColors.dart';

/// Vista para ver el resumen del pedido
class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Pedido? pedido = ModalRoute.of(context)?.settings.arguments as Pedido?;

    if (pedido == null) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("No se han cargado datos del pedido")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- CABECERA RESUMEN ---
            Card(
              color: AppColors.neutroClaro.withAlpha(220),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(color: AppColors.principalOscuro, width: 1),
              ),
              child: ListTile(
                leading: const Icon(Icons.receipt_long,
                    size: 40, color: AppColors.secundario),
                title: Text(
                  "Mesa: ${pedido.mesa}",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secundario),
                ),
                subtitle: Text("Total artículos: ${pedido.totalProductos}", style: const TextStyle(color: AppColors.neutroOscuro),),
              ),
            ),
            const SizedBox(height: 20),
            
            // --- TÍTULO DETALLE PRODUCTOS ---
            const Text("Detalle de productos:",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    color: AppColors.secundarioClaro)),
            const Divider(),

            // --- LISTA DE PRODUCTOS ---
            Expanded(
              child: ListView.builder(
                itemCount: pedido.productos.length,
                itemBuilder: (context, index) {
                  final linea = pedido.productos[index];
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
                              fontSize: 20, color: AppColors.secundario)),
                      subtitle: Text(
                          "${linea.cantidad} x ${linea.producto.precio.toStringAsFixed(2)} €",
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.neutroOscuro)),
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

            // --- TOTAL FINAL ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("TOTAL A PAGAR:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                          color: AppColors.secundarioClaro)),
                  Text(
                    "${pedido.total.toStringAsFixed(2)} €",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secundarioClaro),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // --- BOTÓN VOLVER A EDICIÓN ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secundario,
                ),
                child: const Text(
                  "Volver a edición",
                  style: TextStyle(color: AppColors.neutroClaro),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}