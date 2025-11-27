import 'producto.dart';

class LineaPedido {
  final Producto producto;
  final int cantidad;

  LineaPedido({
    required this.producto, 
    required this.cantidad
    });

  double get subtotal => producto.precio * cantidad;
}