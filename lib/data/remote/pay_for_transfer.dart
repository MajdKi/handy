import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> payfortransfer(
    {required int accountid,
    required String type,
    required double? amount,
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
        "description": " transferd $amount to $accountid",
        "Quantity": 1,
        "amount": 100 * amount!,
        "name": accountid
      }),
      headers: m);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return '';
  }
}
