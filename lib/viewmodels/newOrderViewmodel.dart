import 'package:flutter/material.dart';
import '../models/pedido.dart';
import '../models/lineaPedido.dart';

class NewOrderViewModel extends ChangeNotifier {
  String mesa = '';
  List<LineaPedido> lineas = [];

  void setMesa(String valor) {
    mesa = valor;
    notifyListeners();
  }

  void agregarLineas(List<LineaPedido> nuevasLineas) {
    lineas.addAll(nuevasLineas);
    notifyListeners();
  }

  // Cálculo del total acumulado
  double get total {
    double suma = 0;
    for (var linea in lineas) {
      suma += linea.subtotal;
    }
    return suma;
  }

  // Verificación de que la mesa tenga nombre y productos
  bool get esValido {
    return mesa.isNotEmpty && lineas.isNotEmpty;
  }

  //Creador del pedido final
  Pedido crearPedidoFinal() {
    return Pedido(mesa: mesa, productos: lineas);
  }
}