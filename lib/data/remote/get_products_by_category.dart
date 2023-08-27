import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testtest/core/class/models/product.dart';

Future<List<Product>> getProductsByCat(String catName) async {
  String url = "https://dummyjson.com/products/category/$catName";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200 || response.statusCode == 201) {
    List b = jsonDecode(response.body)['products'];
    List<Product> products = [];
    for (int i = 0; i < b.length; i++) {
      products.add(Product.fromJson(b[i]));
    }

    return products;
  } else {
    return [];
  }
}
