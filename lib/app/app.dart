import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_dashboard/app/features/crypto/domain/usecases/get_crypto_currencies_usecase.dart';
import 'package:crypto_dashboard/app/features/crypto/domain/usecases/subscribe_to_price_updates_usecase.dart';
import 'package:crypto_dashboard/app/features/crypto/view/crypto_list_screen.dart';
import 'package:crypto_dashboard/app/features/crypto/view_models/crypto_view_model.dart';

class CryptoDashboardApp extends StatelessWidget {
  const CryptoDashboardApp({
    required GetCryptocurrenciesUseCase getCryptocurrenciesUseCase,
    required SubscribeToPriceUpdatesUseCase subscribeToPriceUpdatesUseCase,
    super.key,
  })  : _getCryptocurrenciesUseCase = getCryptocurrenciesUseCase,
        _subscribeToPriceUpdatesUseCase = subscribeToPriceUpdatesUseCase;

  final GetCryptocurrenciesUseCase _getCryptocurrenciesUseCase;
  final SubscribeToPriceUpdatesUseCase _subscribeToPriceUpdatesUseCase;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CryptoViewModel(
            getCryptocurrenciesUseCase: _getCryptocurrenciesUseCase,
            subscribeToPriceUpdatesUseCase: _subscribeToPriceUpdatesUseCase,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Crypto Dashboard',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.deepPurpleAccent,
            errorColor: Colors.red,
          ),
        ),
        home: const CryptoListScreen(),
      ),
    );
  }
}