import 'package:app/models/producto.dart';

/// Clase con los productos que mostrará la aplicación. Simula lo sería la información de la base de datos / API
class ProductoData {
  static List<Producto> productos = [
    Producto(nombre: 'Coca-Cola', precio: 2.20),
    Producto(nombre: 'Fanta', precio: 2.20),
    Producto(nombre: 'Agua', precio: 1.5),
    Producto(nombre: 'Estrella', precio: 2.00),
    Producto(nombre: 'Vino', precio: 3.00),
    Producto(nombre: 'Zumo', precio: 1.8),
  ];
}
