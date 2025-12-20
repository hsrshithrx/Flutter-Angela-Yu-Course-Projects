import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima_flutter/screens/loading_screen.dart';

class NetworkHelper{

  NetworkHelper(this.url);

  final Uri url;

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);

    print('Status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // ✅ RETURN DATA
    } else {
      print('Server error: ${response.statusCode}');
      return null;
    }
  }

}

