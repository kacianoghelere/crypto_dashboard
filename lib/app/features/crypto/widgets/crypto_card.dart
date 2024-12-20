import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.colorScheme,
    this.price,
    this.change,
  });

  final String name;
  final String symbol;
  final String imageUrl;
  final double? price;
  final double? change;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final changeColor = change != null
      ? (change! >= 0 ? colorScheme.primary : colorScheme.error)
      : colorScheme.onSurface;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.primary,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                imageUrl,
                height: 50,
                width: 50,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.error,
                  size: 50,
                  color: Colors.grey
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              symbol.toUpperCase(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant
              ),
            ),
            const Spacer(),
            Text(
              price != null ? '\$${price?.toStringAsFixed(2)}' : 'N/A',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (change != null)
              Text(
                '${change!.toStringAsFixed(2)}%',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: changeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}