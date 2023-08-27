import 'dart:convert';

import 'package:http/http.dart' as http;

Future<bool> validate({required String token, required String url}) async {
  Map<String, String> m = {
    'Content-type': 'application/json',
    'Accept': '*/*',
    'Authorization': token
  };
  http.Response response =
      await http.post(Uri.parse(url), headers: m, body: jsonEncode({}));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
