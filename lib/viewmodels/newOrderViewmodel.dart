import 'package:flutter/material.dart';
import '../models/pedido.dart';
import '../models/lineaPedido.dart';

class NewOrderViewModel extends ChangeNotifier {
  String mesa = '';
  List<LineaPedido> lineas = [];

  /// Método para establecer la mesa
  void setMesa(String valor) {
    mesa = valor;
    notifyListeners();
  }

  /// Método para agregar líneas de pedido a la lista
  void agregarLineas(List<LineaPedido> nuevasLineas) {
    lineas.addAll(nuevasLineas);
    notifyListeners();
  }


  /// Método para obtener el total de la orden
  double get total {
    double suma = 0;
    for (var linea in lineas) {
      suma += linea.subtotal;
    }
    return suma;
  }

  /// Método para saber si el pedido es válido (Es decir que tenga mesa y líneas(elementos para pedir))
  bool get esValido {
    return mesa.isNotEmpty && lineas.isNotEmpty;
  }

  /// Método para crear el pedido final
  Pedido crearPedidoFinal() {
    return Pedido(mesa: mesa, productos: lineas);
  }
}