import 'package:flutter/material.dart';

import '../../../../common/app_common.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const imageKey = Key('splash-image');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: SizedBox.expand(
        child: Image.asset(
          AppImages.icSplash,
          key: imageKey,
          fit: BoxFit.cover,
          semanticLabel: 'C-Shop',
        ),
      ),
    );
  }
}
