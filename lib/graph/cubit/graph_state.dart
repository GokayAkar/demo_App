import 'package:demo_app/graph/models/historic_stock_prices.dart';
import 'package:equatable/equatable.dart';

abstract class GraphState extends Equatable {
  const GraphState();

  @override
  List<Object> get props => [];
}

class PricesLoadInProgress extends GraphState {}

class PricesLoadSuccess extends GraphState {
  const PricesLoadSuccess({required this.data});

  final StockPrices data;

  @override
  List<Object> get props => [data];
}

class PricesLoadFailure extends GraphState {}

class UnauthorizedLoad extends GraphState {}
