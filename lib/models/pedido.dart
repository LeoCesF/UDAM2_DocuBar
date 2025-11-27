import 'lineaPedido.dart';

class Pedido {
  final String mesa;
  final List<LineaPedido> productos;

  Pedido({
    required this.mesa, 
    required this.productos
    });

  // Calculo total de todo el pedido
  double get total {
    double suma = 0;
    for (var linea in productos) {
      suma += linea.subtotal;
    }
    return suma;
  }

  // Cantidad total de productos 
  int get totalProductos {
    int suma = 0;
    for (var linea in productos) {
      suma += linea.cantidad;
    }
    return suma;
  }
}