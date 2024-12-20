# crypto_dashboard
A crypto currency pricing dashboard built based on the article [Architecting Flutter Apps the Right Way: A Practical Guide with Command Pattern and MVVM](https://hapkiduki.medium.com/architecting-flutter-apps-the-right-way-a-practical-guide-with-command-pattern-and-mvvm-55fbff068186) by @Hapkiduki.

This project aims to reproduce the new architecture proposition made by the Flutter Dev team.

## Project structure
```
lib/
├── app
│   ├── app.dart
│   ├── features
│   │   └── crypto
│   │       ├── data
│   │       │   ├── models
│   │       │   │   ├── crypto_currency.dart
│   │       │   │   └── price.dart
│   │       │   └── repositories
│   │       │       ├── crypto_repository.dart
│   │       │       └── crypto_repository_impl.dart
│   │       ├── domain
│   │       │   └── usecases
│   │       │       ├── get_crypto_currencies_usecase.dart
│   │       │       └── subscribe_to_price_updates_usecase.dart
│   │       ├── view
│   │       │   └── crypto_list_screen.dart
│   │       ├── view_models
│   │       │   └── crypto_view_model.dart
│   │       └── widgets
│   │           └── crypto_card.dart
│   └── shared
│       └── core
│           ├── base_use_case.dart
│           ├── command.dart
│           ├── result.dart
│           └── stream_command.dart
└── main.dart
```

![image](https://github.com/user-attachments/assets/e65807b8-3fb0-420f-b820-ed8536e2aa08)
