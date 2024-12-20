import 'package:flutter/material.dart';

import 'package:crypto_dashboard/app/shared/core/result.dart';

class Command<T, Params> {
  Command(this._action);

  final Future<Result<T>> Function(Params params) _action;
  final ValueNotifier<bool> isExecuting = ValueNotifier(false);
  final ValueNotifier<Result<T>?> result = ValueNotifier(null);

  Future<void> execute(Params params) async {
    if (isExecuting.value) return;
    isExecuting.value = true;
    result.value = null;

    try {
      final res = await _action(params);
      result.value = res;
    } finally {
      isExecuting.value = false;
    }
  }

  void dispose() {
    isExecuting.dispose();
    result.dispose();
  }
}
