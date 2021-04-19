// To parse this JSON data, do
//
//     final stockPrices = stockPricesFromJson(jsonString);

import 'dart:convert';

StockPrices stockPricesFromJson(String str) => StockPrices.fromJson(
      json.decode(str),
    );

class StockPrices {
  const StockPrices({
    required this.daily,
    required this.weekly,
    required this.monthly,
    required this.threeMonth,
    required this.annual,
    required this.fiveYear,
    required this.code,
    required this.symbol,
  });

  factory StockPrices.fromJson(Map<String, dynamic> json) => StockPrices(
        daily: List<PriceEntry>.from(
          // ignore: avoid_dynamic_calls
          json['1G'].map((x) => PriceEntry.fromJson(x)),
        ),
        weekly: List<PriceEntry>.from(
          // ignore: avoid_dynamic_calls
          json['1H'].map((x) => PriceEntry.fromJson(x)),
        ),
        monthly: List<PriceEntry>.from(
          // ignore: avoid_dynamic_calls
          json['1A'].map((x) => PriceEntry.fromJson(x)),
        ),
        threeMonth: List<PriceEntry>.from(
          // ignore: avoid_dynamic_calls
          json['3A'].map((x) => PriceEntry.fromJson(x)),
        ),
        annual: List<PriceEntry>.from(
          // ignore: avoid_dynamic_calls
          json['1Y'].map((x) => PriceEntry.fromJson(x)),
        ),
        fiveYear: List<PriceEntry>.from(
          // ignore: avoid_dynamic_calls
          json['5Y'].map((x) => PriceEntry.fromJson(x)),
        ),
        code: json['Code'],
        symbol: json['symbol'],
      );

  final List<PriceEntry> daily;
  final List<PriceEntry> weekly;
  final List<PriceEntry> monthly;
  final List<PriceEntry> threeMonth;
  final List<PriceEntry> annual;
  final List<PriceEntry> fiveYear;
  final String code;
  final String symbol;
}

class PriceEntry {
  const PriceEntry({
    required this.dateAsMsSinceEpoch,
    required this.price,
  });

  factory PriceEntry.fromJson(Map<String, dynamic> json) => PriceEntry(
        dateAsMsSinceEpoch: json['d'],
        // ignore: avoid_dynamic_calls
        price: json['c'].toDouble(),
      );

  final int dateAsMsSinceEpoch;
  final double price;
}
