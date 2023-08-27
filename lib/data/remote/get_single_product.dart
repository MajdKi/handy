import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testtest/core/class/models/product.dart';

Future<Product> getSingleProduct(int id) async {
  String url = "https://dummyjson.com/products/$id";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Product product = Product.fromJson(jsonDecode(response.body));
    return product;
  } else {
    throw "Error";
  }
}
