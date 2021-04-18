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
    final stockPricesResponse = await httpClient.get(
      Uri.parse(_baseUrl),
      headers: {HttpHeaders.authorizationHeader: _authorizationHeader},
    );

    return stockPricesFromJson(stockPricesResponse.body);
  }
}
