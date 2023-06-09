import 'package:up_invest_front/app/core/adapter/http/http_client_adapter.dart';
import 'package:up_invest_front/app/core/env.dart';

sealed class ICurrencyExchangeRepository {
  Future<double> getExchangeRate(
      {required String baseCurrency, required String targetCurrency});
}

class CurrencyExchangeRepository extends ICurrencyExchangeRepository {
  CurrencyExchangeRepository({required this.httpClientAdapter});

  final IHttpClientAdapter httpClientAdapter;
  final String baseUrl = 'https://v6.exchangerate-api.com/v6/';
  final String key = currencyExchangeKey;

  @override
  Future<double> getExchangeRate(
      {required String baseCurrency, required String targetCurrency}) async {
    final response = await httpClientAdapter.get(
      path: '$baseUrl/$key/pair/$baseCurrency/$targetCurrency',
    );

    return response.data['conversion_rate'];
  }
}
