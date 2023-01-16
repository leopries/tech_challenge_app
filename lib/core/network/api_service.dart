import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.openai.com/v1/completions';

  static Future<Map<String, String>> getHeader() async {
    final base = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer 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',
    };

    return base;
  }

  static Future<dynamic> postRequest(String path,
      {Map<String, dynamic>? body}) async {
    final headers = await ApiService.getHeader();
    String encodedBody = "";
    if (body != null) {
      body.addAll({
        "model": "davinci:ft-personal-2023-01-14-20-14-01",
        "temperature": 0,
        "max_tokens": 16,
        "top_p": 1,
        "n": 1,
        "logprobs": null
      });
      encodedBody = json.encode(body);
    }

    final response = await http.post(Uri.parse('$baseUrl$path'),
        headers: headers, body: encodedBody);
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      debugPrint(response.body);
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get $path');
    }
  }
}
