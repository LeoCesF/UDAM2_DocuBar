import 'producto.dart';

/// Modelo con los datos y métodos de una línea de pedido
class LineaPedido {
  final Producto producto;
  final int cantidad;

  LineaPedido({
    required this.producto, 
    required this.cantidad
    });

  /// Método para obtener el precio de la cantidad del producto en cuestión
  double get subtotal => producto.precio * cantidad;
}