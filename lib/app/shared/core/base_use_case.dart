import 'package:crypto_dashboard/app/shared/core/result.dart';

abstract interface class BaseUseCase<Type, Params> {
  Future<Result<Type>> call(Params params);
}

abstract interface class StreamUseCase<Type, Params> {
  Stream<Result<Type>> call(Params params);
}

final class NoParams {}