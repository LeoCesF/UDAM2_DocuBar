import 'lineaPedido.dart';

/// Modelo con los datos y métodos de un pedido
class Pedido {
  final String mesa;
  final List<LineaPedido> productos;

  Pedido({
    required this.mesa, 
    required this.productos
    });


  /// Método para obtener el total de la orden
  double get total {
    double suma = 0;
    for (var linea in productos) {
      suma += linea.subtotal;
    }
    return suma;
  }

  /// Método para obtener el total de productos en la orden
  int get totalProductos {
    int suma = 0;
    for (var linea in productos) {
      suma += linea.cantidad;
    }
    return suma;
  }
}