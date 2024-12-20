import 'package:crypto_dashboard/app/features/crypto/data/models/crypto_currency.dart';
import 'package:crypto_dashboard/app/features/crypto/data/models/price.dart';

abstract interface class CryptoRepository {
  Future<List<CryptoCurrency>> getCryptocurrencies();

  Stream<Price> subscribeToPriceUpdates(List<String> cryptoIds);
}