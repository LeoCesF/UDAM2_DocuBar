import 'package:flutter/material.dart';
import '../data/producto_data.dart';
import '../models/producto.dart';
import '../models/lineaPedido.dart';

class ChooseViewModel extends ChangeNotifier {
  final Map<Producto, int> _cantidades = {};
  
  /// Variable para saber qué producto está seleccionado (foco)
  Producto? _productoSeleccionado;

  ChooseViewModel() {
    for (var p in ProductoData.productos) {
      _cantidades[p] = 0;
    }
  }

  /// Método para obtener la cantidad de un producto
  int getCantidad(Producto p) => _cantidades[p] ?? 0;

  /// Método para saber si un producto está seleccionado en la UI
  bool isSelected(Producto p) => _productoSeleccionado == p;

  /// Método para cambiar la selección (Marca dónde ha clicado el usuario y lo resalta en la UI)
  void SelectProduct(Producto p) {
    if (_productoSeleccionado != p) {
      _productoSeleccionado = p;
      notifyListeners();
    }
  }

  /// Método para aumentar la cantidad de un producto
  void Increase(Producto p) {
    _cantidades[p] = (_cantidades[p] ?? 0) + 1;
    notifyListeners();
  }

  /// Método para disminuir la cantidad de un producto
  void Decrease(Producto p) {
    int current = _cantidades[p] ?? 0;
    if (current > 0) {
      _cantidades[p] = current - 1;
      notifyListeners();
    }
  }

  /// Método que recoge todo el pedido (todos los productos seleccionados, más sus cantidades seleccionadas)
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