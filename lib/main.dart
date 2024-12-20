import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:crypto_dashboard/app/app.dart';
import 'package:crypto_dashboard/app/features/crypto/data/repositories/crypto_repository_impl.dart';
import 'package:crypto_dashboard/app/features/crypto/domain/usecases/get_crypto_currencies_usecase.dart';
import 'package:crypto_dashboard/app/features/crypto/domain/usecases/subscribe_to_price_updates_usecase.dart';

void main() {
  final dio = Dio();
  final repository = CryptoRepositoryImpl(dio);
  final getCryptocurrenciesUseCase = GetCryptocurrenciesUseCase(repository);
  final subscribeToPriceUpdatesUseCase = SubscribeToPriceUpdatesUseCase(repository);

  runApp(CryptoDashboardApp(
    getCryptocurrenciesUseCase: getCryptocurrenciesUseCase,
    subscribeToPriceUpdatesUseCase: subscribeToPriceUpdatesUseCase,
  ));
}