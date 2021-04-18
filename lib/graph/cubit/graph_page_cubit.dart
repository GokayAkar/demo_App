// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';
import 'package:demo_app/graph/cubit/graph_state.dart';
import 'package:demo_app/graph/graph.dart';
import 'package:http/http.dart' as http;

import '../repositories/stock_api_client.dart';

class GraphPageCubit extends Cubit<GraphState> {
  GraphPageCubit() : super(PricesLoadInProgress()) {
    getStockPrices();
  }

  final stockApiClient = StockApiClient(httpClient: http.Client());

  void getStockPrices() async {
    emit(PricesLoadInProgress());
    try {
      final stockPrices = await stockApiClient.getStockPrices();
      emit(PricesLoadSuccess(data: stockPrices));
    } on UnauthorizedAccessException {
      emit(UnauthorizedLoad());
    } catch (e) {
      emit(PricesLoadFailure());
    }
  }
}
