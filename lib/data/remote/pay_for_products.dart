import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> payforproducts(
    {required int id,
    required String type,
    required int quantity,
    required int amount,
    required String name,
    required String token,
    required String url}) async {
  Map<String, String> m = {
    'content-type': 'application/json',
    'accept': '*/*',
    'Authorization': token
  };
  http.Response response = await http.post(Uri.parse(url),
      body: jsonEncode({
        "product_id": id,
        "type": type,
        "Quantity": quantity,
        "description": " Paid $amount on $quantity of $name",
        "amount": 100 * amount,
        "name": name
      }),
      headers: m);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return '';
  }
}
