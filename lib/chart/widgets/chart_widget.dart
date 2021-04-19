import 'package:demo_app/chart/cubit/chart_page_cubit.dart';
import 'package:demo_app/chart/cubit/chart_state.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

class ChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff232d37),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18.0,
                left: 12.0,
                top: 24,
              ),
              child: LineChart(
                LineChartData(
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
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      rotateAngle: 270,
                      showTitles: false,
                      reservedSize: 50,
                      // getTextStyles: (value) => const TextStyle(
                      //   color: Colors.orange,
                      //   fontWeight: FontWeight.bold,
                      //   fontSize: 10,
                      // ),
                      // getTitles: (value) {
                      //   return DateFormat('dd.MM').format(DateTime.fromMillisecondsSinceEpoch(value.toInt()));
                      // },
                    ),
                    leftTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: (context.read<ChartPageCubit>().state as DataLoadedSuccesfully).spots,
                      isCurved: false,
                      colors: gradientColors,
                      barWidth: 1,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _HandleChartButton(presentType: PresentType.daily, buttonName: "Daily"),
              _HandleChartButton(presentType: PresentType.weekly, buttonName: "Weekly"),
              _HandleChartButton(presentType: PresentType.monthly, buttonName: "Monthly"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _HandleChartButton(presentType: PresentType.threeMonth, buttonName: "3-Month"),
              _HandleChartButton(presentType: PresentType.annual, buttonName: "Annual"),
              _HandleChartButton(presentType: PresentType.fiveYear, buttonName: "5-Year"),
            ],
          ),
        ],
      ),
    );
  }
}

class _HandleChartButton extends StatelessWidget {
  const _HandleChartButton({required this.presentType, required this.buttonName, Key? key}) : super(key: key);

  final PresentType presentType;
  final String buttonName;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => context.read<ChartPageCubit>().changePresentation(presentType),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: screenSize.height * .01),
        width: screenSize.width * .25,
        height: screenSize.height * .05,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
        child: Text(
          buttonName,
          style: TextStyle(color: Colors.orange),
        ),
      ),
    );
  }
}
