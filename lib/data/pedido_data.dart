import '../models/pedido.dart';
import '../models/lineaPedido.dart';
import 'producto_data.dart'; 

/// Clase con los pedidos iniciales que mostrará la aplicación. Simula lo sería la información de la base de datos / API
class PedidoData {
  static List<Pedido> pedidosIniciales = [
    Pedido(
      mesa: "1",
      productos: [

        LineaPedido(producto: ProductoData.productos[0], cantidad: 2),

        LineaPedido(producto: ProductoData.productos[2], cantidad: 1),
      ],
    ),

    Pedido(
      mesa: "5",
      productos: [
        LineaPedido(producto: ProductoData.productos[3], cantidad: 4), 
        LineaPedido(producto: ProductoData.productos[1], cantidad: 1), 
      ],
    ),
  ];
}