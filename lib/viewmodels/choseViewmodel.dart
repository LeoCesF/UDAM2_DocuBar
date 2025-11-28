import 'package:flutter/material.dart';
import '../data/producto_data.dart';
import '../models/producto.dart';
import '../models/lineaPedido.dart';

class ChooseViewModel extends ChangeNotifier {
  final Map<Producto, int> _cantidades = {};
  
  // Variable para saber qué producto está seleccionado (foco)
  Producto? _productoSeleccionado;

  ChooseViewModel() {
    for (var p in ProductoData.productos) {
      _cantidades[p] = 0;
    }
  }

  int getCantidad(Producto p) => _cantidades[p] ?? 0;

  // Getter para saber si un producto específico está seleccionado
  bool isSelected(Producto p) => _productoSeleccionado == p;

  // Método para cambiar la selección
  void SelectProduct(Producto p) {
    if (_productoSeleccionado != p) {
      _productoSeleccionado = p;
      notifyListeners();
    }
  }

  void Increase(Producto p) {
    _cantidades[p] = (_cantidades[p] ?? 0) + 1;
    notifyListeners();
  }

  void Decrease(Producto p) {
    int current = _cantidades[p] ?? 0;
    if (current > 0) {
      _cantidades[p] = current - 1;
      notifyListeners();
    }
  }

  List<LineaPedido> getSelection() {
    List<LineaPedido> seleccion = [];
    _cantidades.forEach((producto, cantidad) {
      if (cantidad > 0) {
        seleccion.add(LineaPedido(producto: producto, cantidad: cantidad));
      }
    });
    return seleccion;
  }
}