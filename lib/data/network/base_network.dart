import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:volantisassignmenttoaditya/application/key_constant.dart';

import '../../application/uri_constant.dart';

class BaseNetwork {
  String baseUrl = MasterUri.baseUrl.prodUrl;
  String apiKey = ApiKeyWeather.apiKey.rapidApiKey;
  String apiHost = ApiKeyWeather.apiKey.rapidApiHost;

  Future<Map?> getList(String pathUrl) async {
    try {
      final fullUrl = "$baseUrl/$pathUrl";
      debugPrint("BaseNetwork is Running - fullUrl : $fullUrl");

      final response = await http.Client().get(Uri.parse(fullUrl), headers: {
        "X-RapidAPI-Key": apiKey,
        "X-RapidAPI-Host": apiHost,
      });

      return _processListResponse(response);
    } finally {
      http.Client().close();
    }
  }

  Future<Map?> _processListResponse(http.Response response) async {
    final body = response.body;

    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      if (jsonBody['error'] != null) {
        return {"error": true};
      } else {
        debugPrint('data : $jsonBody');
        return jsonBody;
      }
    } else {
      debugPrint("Process Response is error");
      return {"error": true};
    }
  }
}
