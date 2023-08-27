import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> payforbills(
    {required int lastid,
    required String type,
    required double? amount,
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
        "product_id": 0,
        "type": type,
        "description":
            " Paid $amount on $name bill with last bill id : $lastid",
        "Quantity": 1,
        "amount": 100 * amount!,
        "name": name
      }),
      headers: m);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return '';
  }
}
