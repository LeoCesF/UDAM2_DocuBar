import 'package:flutter/material.dart';
import '../models/pedido.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // RECUPERAR ARGUMENTOS:
    // Aquí extraemos el objeto Pedido que enviamos desde NewOrder con pushNamed
    final Pedido? pedido = ModalRoute.of(context)?.settings.arguments as Pedido?;

    // Validación de seguridad por si entra sin argumentos
    if (pedido == null) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("No se han cargado datos del pedido")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Resumen Final'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CABECERA
            Card(
              color: Colors.blue.shade50,
              child: ListTile(
                leading: const Icon(Icons.receipt_long, size: 40, color: Colors.blue),
                title: Text(
                  "Mesa: ${pedido.mesa}",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Total artículos: ${pedido.totalProductos}"),
              ),
            ),
            const SizedBox(height: 20),
            
            const Text("Detalle de productos:", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),

            // LISTA DE PRODUCTOS (Solo lectura)
            Expanded(
              child: ListView.builder(
                itemCount: pedido.productos.length,
                itemBuilder: (context, index) {
                  final linea = pedido.productos[index];
                  return ListTile(
                    dense: true,
                    title: Text(linea.producto.nombre, 
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    // Mostramos Cantidad x PrecioUnitario
                    subtitle: Text("${linea.cantidad} x ${linea.producto.precio.toStringAsFixed(2)} €"),
                    trailing: Text(
                      "${linea.subtotal.toStringAsFixed(2)} €",
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
            
            const Divider(thickness: 2),

            // TOTAL FINAL
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("TOTAL A PAGAR:", 
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(
                    "${pedido.total.toStringAsFixed(2)} €",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // BOTÓN VOLVER
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Volver a edición"),
                onPressed: () {
                  // REQUISITO: Volver con pop (sin devolver datos ni borrar nada)
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