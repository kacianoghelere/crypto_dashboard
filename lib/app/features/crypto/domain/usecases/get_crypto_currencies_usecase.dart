import 'package:crypto_dashboard/app/features/crypto/data/models/crypto_currency.dart';
import 'package:crypto_dashboard/app/features/crypto/data/repositories/crypto_repository.dart';
import 'package:crypto_dashboard/app/shared/core/base_use_case.dart';
import 'package:crypto_dashboard/app/shared/core/result.dart';

class GetCryptocurrenciesUseCase implements BaseUseCase<List<CryptoCurrency>, NoParams> {
  GetCryptocurrenciesUseCase(this.repository);

  final CryptoRepository repository;

  @override
  Future<Result<List<CryptoCurrency>>> call(NoParams params) async {
    try {
      final cryptocurrencies = await repository.getCryptocurrencies();

      return Success(cryptocurrencies);
    } catch (e, s) {
      return Error(
        Failure(
          message: 'Failed to get cryptocurrencies',
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }
}