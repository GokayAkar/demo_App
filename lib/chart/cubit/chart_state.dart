import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

abstract class ChartState extends Equatable {
  const ChartState();

  @override
  List<Object> get props => [];
}

class DataLoading extends ChartState {}

class DataLoadFailed extends ChartState {}

class UnauthorizedLoad extends ChartState {}

class DataLoadedSuccesfully extends ChartState {
  const DataLoadedSuccesfully({required this.spots});

  final List<FlSpot> spots;

  @override
  List<Object> get props => [spots];

  DataLoadedSuccesfully copyWith({
    List<FlSpot>? spots,
  }) {
    return DataLoadedSuccesfully(
      spots: spots ?? this.spots,
    );
  }
}
