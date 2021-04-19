// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';
import 'package:demo_app/chart/cubit/chart_state.dart';
import 'package:demo_app/chart/chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

import '../repositories/stock_api_client.dart';

enum PresentType { daily, weekly, monthly, threeMonth, annual, fiveYear }

class ChartPageCubit extends Cubit<ChartState> {
  ChartPageCubit() : super(DataLoading()) {
    getStockPrices();
  }

  final _stockApiClient = StockApiClient(httpClient: http.Client());
  late StockPrices _stockPrices;
  PresentType _presentType = PresentType.daily;

  void getStockPrices() async {
    emit(DataLoading());
    try {
      _stockPrices = await _stockApiClient.getStockPrices();
      emit(
        DataLoadedSuccesfully(
          spots: _getFlSpots(),
        ),
      );
    } on UnauthorizedAccessException {
      emit(UnauthorizedLoad());
    } catch (e) {
      emit(DataLoadFailed());
    }
  }

  void changePresentation(PresentType presentType) {
    _presentType = presentType;
    emit(
      DataLoadedSuccesfully(
        spots: _getFlSpots(),
      ),
    );
  }

  // returns spots for active state
  List<FlSpot> _getFlSpots() {
    switch (_presentType) {
      case PresentType.daily:
        return _stockPrices.daily.map(_getFlSpot).toList();
      case PresentType.weekly:
        return _stockPrices.weekly.map(_getFlSpot).toList();
      case PresentType.monthly:
        return _stockPrices.monthly.map(_getFlSpot).toList();
      case PresentType.threeMonth:
        return _stockPrices.threeMonth.map(_getFlSpot).toList();
      case PresentType.annual:
        return _stockPrices.annual.map(_getFlSpot).toList();
      case PresentType.fiveYear:
        return _stockPrices.fiveYear.map(_getFlSpot).toList();
      default:
        return _stockPrices.daily.map(_getFlSpot).toList();
    }
  }

  // takes an priceEntry and returns its FlSpot
  FlSpot _getFlSpot(PriceEntry priceEntry) {
    return FlSpot(priceEntry.dateAsMsSinceEpoch.toDouble(), priceEntry.price);
  }
}
