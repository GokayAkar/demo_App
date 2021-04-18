import 'package:demo_app/graph/models/historic_stock_prices.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphWidget extends StatefulWidget {
  GraphWidget({Key? key, required this.data}) : super(key: key);
  late final StockPrices data;
  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
