import 'package:demo_app/graph/cubit/graph_page_cubit.dart';
import 'package:demo_app/graph/cubit/graph_state.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraphWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Color(0xff232d37),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18.0,
                left: 12.0,
                top: 24,
                bottom: 12,
              ),
              child: LineChart(LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xff37434d),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: const Color(0xff37434d),
                      strokeWidth: 1,
                    );
                  },
                ),
                // titlesData: FlTitlesData(
                //   show: true,
                //   bottomTitles: SideTitles(
                //     showTitles: true,
                //     reservedSize: 22,
                //     getTextStyles: (value) => const TextStyle(
                //       color: Color(0xff68737d),
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16,
                //     ),
                //     getTitles: (value) {
                //       switch (value.toInt()) {
                //         case 2:
                //           return 'MAR';
                //         case 5:
                //           return 'JUN';
                //         case 8:
                //           return 'SEP';
                //       }
                //       return '';
                //     },
                //     margin: 8,
                //   ),
                //   leftTitles: SideTitles(
                //     showTitles: true,
                //     getTextStyles: (value) => const TextStyle(
                //       color: Color(0xff67727d),
                //       fontWeight: FontWeight.bold,
                //       fontSize: 15,
                //     ),
                //     getTitles: (value) {
                //       switch (value.toInt()) {
                //         case 1:
                //           return '10k';
                //         case 3:
                //           return '30k';
                //         case 5:
                //           return '50k';
                //       }
                //       return '';
                //     },
                //     reservedSize: 28,
                //     margin: 12,
                //   ),
                // ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: const Color(0xff37434d),
                    width: 1,
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: (context.read<GraphPageCubit>().state as PricesLoadSuccess).spots,
                    isCurved: false,
                    colors: gradientColors,
                    barWidth: 1,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: false,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      colors: gradientColors
                          .map(
                            (color) => color.withOpacity(0.3),
                          )
                          .toList(),
                    ),
                  ),
                ],
              )),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: () => context.read<GraphPageCubit>().changePresentation(PresentType.daily), child: Text("Daily")),
            ElevatedButton(onPressed: () => context.read<GraphPageCubit>().changePresentation(PresentType.weekly), child: Text("Weekly")),
            ElevatedButton(onPressed: () => context.read<GraphPageCubit>().changePresentation(PresentType.monthly), child: Text("Monthly")),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: () => context.read<GraphPageCubit>().changePresentation(PresentType.threeMonth), child: Text("3-Month")),
            ElevatedButton(onPressed: () => context.read<GraphPageCubit>().changePresentation(PresentType.annual), child: Text("Annual")),
            ElevatedButton(onPressed: () => context.read<GraphPageCubit>().changePresentation(PresentType.fiveYear), child: Text("5-Year")),
          ],
        ),
      ],
    );
  }
}
