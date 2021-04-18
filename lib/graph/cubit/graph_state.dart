import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

abstract class GraphState extends Equatable {
  const GraphState();

  @override
  List<Object> get props => [];
}

class PricesLoadInProgress extends GraphState {}

class PricesLoadFailure extends GraphState {}

class UnauthorizedLoad extends GraphState {}

class PricesLoadSuccess extends GraphState {
  const PricesLoadSuccess({required this.spots});

  final List<FlSpot> spots;

  @override
  List<Object> get props => [spots];

  PricesLoadSuccess copyWith({
    List<FlSpot>? spots,
  }) {
    return PricesLoadSuccess(
      spots: spots ?? this.spots,
    );
  }
}
