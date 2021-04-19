import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/historic_stock_prices.dart';

class StockApiClient {
  StockApiClient({
    required this.httpClient,
  });

  static const String _baseUrl = 'https://finfree.app/demo';
  static const String _authorizationHeader = 'R29vZCBMdWNr';
  final http.Client httpClient;

  Future<StockPrices> getStockPrices() async {
    final response = await httpClient.get(
      Uri.parse(_baseUrl),
      headers: {HttpHeaders.authorizationHeader: _authorizationHeader},
    );
    //throw Exception();
    if (response.statusCode == 200) {
      return stockPricesFromJson(response.body);
    } else if (response.statusCode == 401) {
      throw const UnauthorizedAccessException();
    } else {
      throw Exception('Something went wrong!');
    }
  }
}

class UnauthorizedAccessException implements Exception {
  const UnauthorizedAccessException();
  @override
  String toString() {
    return 'Unauthorized access!';
    // return super.toString(); // Instance of HttpException
  }
}
