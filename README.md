# crypto_dashboard

A crypto currency pricing dashboard Flutter project built based on the article [Architecting Flutter Apps the Right Way: A Practical Guide with Command Pattern and MVVM by Hapkiduki (Andres Felipe Corrales Ortiz)](https://hapkiduki.medium.com/architecting-flutter-apps-the-right-way-a-practical-guide-with-command-pattern-and-mvvm-55fbff068186).

This project aims to reproduce the new architecture proposition made by the Flutter Dev team.

## Project structure
```
lib/
├── app
│   ├── app.dart
│   └── features
│       └── crypto
│           ├── data
│           │   ├── models
│           │   │   ├── crypto_currency.dart
│           │   │   └── price.dart
│           │   └── respositories
│           │       ├── crypto_repository.dart
│           │       └── crypto_repository_impl.dart
│           ├── domain
│           │   └── usecases
│           │       ├── get_crypto_currencies_usecase.dart
│           │       └── subscribe_to_price_updates_usecase.dart
│           ├── view
│           │   └── crypto_list_screen.dart
│           └── view_models
│               └── crypto_view_model.dart
└── main.dart
```