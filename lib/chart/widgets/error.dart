import 'package:demo_app/chart/cubit/chart_page_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ErrorOccuredWidget extends StatelessWidget {
  const ErrorOccuredWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Something went wrong'),
          TextButton(
            // ignore: avoid_dynamic_calls
            onPressed: () => context.read<ChartPageCubit>().getStockPrices(),
            child: const Text('fetch data again'),
          ),
        ],
      ),
    );
  }
}
