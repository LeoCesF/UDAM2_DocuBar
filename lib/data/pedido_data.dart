import '../models/pedido.dart';
import '../models/lineaPedido.dart';
import 'producto_data.dart'; // Importamos tus productos

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
        LineaPedido(producto: ProductoData.productos[3], cantidad: 4), // Estrellas
        LineaPedido(producto: ProductoData.productos[1], cantidad: 1), // Fanta
      ],
    ),
  ];
}