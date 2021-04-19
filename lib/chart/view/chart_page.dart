// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:demo_app/chart/cubit/chart_state.dart';
import 'package:demo_app/chart/widgets/chart_widget.dart';
import 'package:demo_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../chart.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChartPageCubit(),
      child: const ChartView(),
    );
  }
}

class ChartView extends StatelessWidget {
  const ChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];
    final Shader linearGradient = LinearGradient(colors: gradientColors).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          l10n.counterAppBarTitle,
          style: TextStyle(foreground: Paint()..shader = linearGradient),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: BlocBuilder(
        bloc: context.read<ChartPageCubit>(),
        buildWhen: (previous, current) {
          return previous != current;
        },
        builder: (context, state) {
          if (state is DataLoading) {
            return const LoadingWidget();
          }
          if (state is DataLoadFailed) {
            return const ErrorOccuredWidget();
          }
          if (state is UnauthorizedLoad) {
            return const UnauthorizedAccessWidget();
          }
          if (state is DataLoadedSuccesfully) {
            return ChartWidget();
          }
          return Center(
            child: TextButton(
              onPressed: () => context.read<ChartPageCubit>().getStockPrices(),
              child: const Text('Fetch Data'),
            ),
          );
        },
      ),
    );
  }
}
