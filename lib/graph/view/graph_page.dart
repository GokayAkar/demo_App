// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:demo_app/graph/cubit/graph_state.dart';
import 'package:demo_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../graph.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GraphPageCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
        appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
        body: BlocBuilder(
          bloc: context.read<GraphPageCubit>(),
          buildWhen: (previous, current) {
            return previous != current;
          },
          builder: (context, state) {
            if (state is PricesLoadInProgress) {
              return const LoadingWidget();
            }
            if (state is PricesLoadFailure) {
              return const ErrorOccuredWidget();
            }
            if (state is UnauthorizedLoad) {
              return const UnauthorizedAccessWidget();
            }
            return Center(
              child: TextButton(
                // ignore: lines_longer_than_80_chars
                onPressed: () => context.read<GraphPageCubit>().getStockPrices(),
                child: const Text('Fetch Data'),
              ),
            );
          },
        ));
  }
}
