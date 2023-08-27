import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> register(
    {required String email,
    required String password,
    required String name,
    required String url,
    required String gender,
    required String state,
    required String date}) async {
  Map<String, String> m = {
    "content-type": "application/json",
    "accept": "*/*",
  };
  http.Response response = await http.post(Uri.parse(url),
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "gender": gender,
        "birthDate": date,
        "state": state,
      }),
      headers: m);
  if (response.statusCode == 200) {
  } else {
    throw ('error');
  }
}
