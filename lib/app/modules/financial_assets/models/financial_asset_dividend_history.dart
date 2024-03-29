import 'package:equatable/equatable.dart';
import 'package:up_invest_front/app/modules/financial_assets/util/convert_asset_helper.dart';
import 'package:up_invest_front/app/modules/settings/model/settings_model.dart'
    show Currency;

class FinancialAssetDividendHistory extends Equatable {
  const FinancialAssetDividendHistory({
    required this.id,
    required this.assetId,
    required this.exDividendDate,
    required this.paymentDate,
    required this.dividendAmount,
    required this.totalDividendAmount,
    required this.quantity,
    required this.currency,
  });

  final int id;
  final int assetId;
  final DateTime exDividendDate;
  final DateTime paymentDate;
  final double dividendAmount;
  final double totalDividendAmount;
  final double quantity;
  final Currency currency;

  factory FinancialAssetDividendHistory.fromJson(Map<String, dynamic> json) {
    switch (json) {
      case {
          'id': int id,
          'assetId': int assetId,
          'exDividendDate': String exDividendDate,
          'paymentDate': String paymentDate,
          'dividendAmount': double dividendAmount,
          'totalDividendAmount': double totalDividendAmount,
          'quantity': double quantity,
          'currency': String currency
        }:
        return FinancialAssetDividendHistory(
          id: id,
          assetId: assetId,
          exDividendDate: DateTime.parse(exDividendDate),
          paymentDate: DateTime.parse(paymentDate),
          dividendAmount: dividendAmount,
          totalDividendAmount: totalDividendAmount,
          quantity: quantity,
          currency: stringToCurrency(currency),
        );

      default:
        throw Exception('invalid-json');
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'assetId': assetId,
        'exDividendDate': exDividendDate.toIso8601String(),
        'paymentDate': paymentDate.toIso8601String(),
        'dividendAmount': dividendAmount,
        'totalDividendAmount': totalDividendAmount,
        'quantity': quantity,
        'currency': currencyToString(currency),
      };
  @override
  List<Object?> get props => [
        id,
        assetId,
        exDividendDate,
        paymentDate,
        dividendAmount,
        totalDividendAmount,
        quantity,
        currency,
      ];
}
