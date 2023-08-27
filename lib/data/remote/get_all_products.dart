import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testtest/core/class/models/product.dart';

Future<List<Product>> getAllProducts() async {
  String url = "https://dummyjson.com/products";
  http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<Product> products = [];
    List b = jsonDecode(response.body)['products'];
    for (int i = 0; i < products.length; i++) {
      products.add(Product.fromJson(b[i]));
    }
    return products;
  } else {
    throw 'error';
  }
}
