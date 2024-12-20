import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_dashboard/app/features/crypto/view_models/crypto_view_model.dart';
import 'package:crypto_dashboard/app/features/crypto/widgets/crypto_card.dart';
import 'package:crypto_dashboard/app/shared/core/base_use_case.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  @override
  void initState() {
    super.initState();

    final viewModel = Provider.of<CryptoViewModel>(context, listen: false);
    viewModel.addListener(_handleError);
  }

  @override
  void dispose() {
    final viewModel = Provider.of<CryptoViewModel>(context, listen: false);
    viewModel.removeListener(_handleError);

    super.dispose();
  }

  void _handleError() {
    final viewModel = Provider.of<CryptoViewModel>(context, listen: false);

    if (viewModel.errorMessage != null) {
      final snackBar = SnackBar(
        content: Text(
          viewModel.errorMessage!,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: () {
            viewModel.clearError();
            viewModel.getCryptocurrenciesCommand.execute(NoParams());
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      viewModel.clearError(); // Clear error after showing the snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CryptoViewModel>(context);

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Prices'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        centerTitle: true,
        elevation: 4,
      ),
      body: AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          if (viewModel.cryptocurrencies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 3 / 4,
              ),
              itemCount: viewModel.cryptocurrencies.length,
              itemBuilder: (context, index) {
                final crypto = viewModel.cryptocurrencies[index];
                final price = viewModel.prices[crypto.id];

                return CryptoCard(
                  name: crypto.name,
                  symbol: crypto.symbol,
                  imageUrl: crypto.imageUrl,
                  price: price?.currentPrice,
                  change: price?.priceChangePercentage24h,
                  colorScheme: colorScheme,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
