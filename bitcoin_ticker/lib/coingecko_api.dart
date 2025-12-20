import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinGeckoApi {
  static const String _baseUrl =
      'https://api.coingecko.com/api/v3/simple/price';

  Future<double> getPrice({
    required String cryptoId,
    required String currency,
  }) async {
    final url = Uri.parse(
      '$_baseUrl?ids=$cryptoId&vs_currencies=$currency',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data[cryptoId][currency]).toDouble();
    } else {
      throw Exception('Failed to load price');
    }
  }
}
