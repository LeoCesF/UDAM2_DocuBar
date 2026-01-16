import 'package:flutter/material.dart';
import '../models/pedido.dart';
import '../data/pedido_data.dart';

class HomeViewModel extends ChangeNotifier {
  // Lista de pedidos actuales
  List<Pedido> pedidos = [];

  HomeViewModel() {
    _cargarDatosIniciales();
  }

  /// Método que carga los datos iniciales que tenemos como data
  void _cargarDatosIniciales() {
    pedidos.addAll(PedidoData.pedidosIniciales);
    notifyListeners();
  }

  void agregarPedido(Pedido pedido) {
    pedidos.add(pedido);
    notifyListeners(); 
  }
}