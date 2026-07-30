import 'package:flutter/material.dart';

import '../../../models/enums/load_status.dart';

class CShopAsyncView extends StatelessWidget {
  const CShopAsyncView({
    required this.status,
    required this.child,
    this.onRetry,
    super.key,
  });

  final LoadStatus status;
  final Widget child;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      LoadStatus.initial || LoadStatus.loading => const Center(
          child: CircularProgressIndicator(),
        ),
      LoadStatus.failure => Center(
          child: FilledButton(
            onPressed: onRetry,
            child: const Text('Thử lại'),
          ),
        ),
      _ => child,
    };
  }
}
