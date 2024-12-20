import 'package:crypto_dashboard/app/features/crypto/data/models/crypto_currency.dart';
import 'package:crypto_dashboard/app/features/crypto/data/models/price.dart';
import 'package:crypto_dashboard/app/features/crypto/domain/usecases/get_crypto_currencies_usecase.dart';
import 'package:crypto_dashboard/app/features/crypto/domain/usecases/subscribe_to_price_updates_usecase.dart';
import 'package:crypto_dashboard/app/shared/core/base_use_case.dart';
import 'package:crypto_dashboard/app/shared/core/command.dart';
import 'package:crypto_dashboard/app/shared/core/result.dart';
import 'package:crypto_dashboard/app/shared/core/stream_command.dart';
import 'package:flutter/foundation.dart';



class CryptoViewModel extends ChangeNotifier {
  CryptoViewModel({
    required GetCryptocurrenciesUseCase getCryptocurrenciesUseCase,
    required SubscribeToPriceUpdatesUseCase subscribeToPriceUpdatesUseCase,
  })  : _getCryptocurrenciesUseCase = getCryptocurrenciesUseCase,
        _subscribeToPriceUpdatesUseCase = subscribeToPriceUpdatesUseCase {
    getCryptocurrenciesCommand = Command<List<CryptoCurrency>, NoParams>(
      _getCryptocurrencies,
    );
    priceUpdatesCommand = StreamCommand<Price, List<String>>(
      _subscribeToPriceUpdates,
    );

    // Start the initialization process
    _initialize();
  }

  final GetCryptocurrenciesUseCase _getCryptocurrenciesUseCase;
  final SubscribeToPriceUpdatesUseCase _subscribeToPriceUpdatesUseCase;

  late final Command<List<CryptoCurrency>, NoParams> getCryptocurrenciesCommand;
  late final StreamCommand<Price, List<String>> priceUpdatesCommand;

  List<CryptoCurrency> cryptocurrencies = [];
  Map<String, Price> prices = {};

  /// Holds any error message that occurs during operations
  String? errorMessage;

  /// Initializes the ViewModel by fetching cryptocurrencies and starting price updates
  Future<void> _initialize() async {
    await getCryptocurrenciesCommand.execute(NoParams());
    final result = getCryptocurrenciesCommand.result.value;

    if (result is Success<List<CryptoCurrency>>) {
      // Cryptocurrencies are already updated in _getCryptocurrencies
      // Start streaming price updates
      final cryptoIds = cryptocurrencies.map((c) => c.id).toList();
      priceUpdatesCommand.start(cryptoIds);
      priceUpdatesCommand.latestResult.addListener(_onPriceUpdate);
    } else if (result is Error<List<CryptoCurrency>>) {
      // Handle error by setting the error message
      errorMessage = result.failure.message;
      notifyListeners();
    }
  }

  /// Fetches the list of cryptocurrencies
  Future<Result<List<CryptoCurrency>>> _getCryptocurrencies(NoParams params) async {
    final result = await _getCryptocurrenciesUseCase(params);
    result.fold(
      (data) {
        cryptocurrencies = data;
        errorMessage = null; // Clear any previous errors
        notifyListeners();
      },
      (failure) {
        // Handle failure by setting the error message
        errorMessage = failure.message;
        notifyListeners();
      },
    );
    return result;
  }

  /// Subscribes to price updates for the given list of cryptoCurrency IDs
  Stream<Result<Price>> _subscribeToPriceUpdates(List<String> cryptoIds) {
    return _subscribeToPriceUpdatesUseCase(cryptoIds);
  }

  /// Handles new price updates or errors from the priceUpdatesCommand
  void _onPriceUpdate() {
    final result = priceUpdatesCommand.latestResult.value;
    if (result != null) {
      result.fold(
        (price) {
          prices[price.cryptoId] = price;
          errorMessage = null; // Clear any previous errors
          notifyListeners();
        },
        (failure) {
          // Handle error by setting the error message
          errorMessage = failure.message;
          notifyListeners();
        },
      );
    }
  }

  /// Clears the current error message and notifies listeners
  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    priceUpdatesCommand.dispose();
    super.dispose();
  }
}