import 'package:flutter/material.dart';

import '../../../common/app_common.dart';
import '../../../configs/app_configs.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.spacing24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppDimens.radius16),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'C',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimens.spacing20),
                const Text('C-Shop base is ready',
                    style: AppTextStyles.heading),
                const SizedBox(height: AppDimens.spacing8),
                Text(
                  '${AppConfigs.env.envName} · '
                  '${Uri.parse(AppConfigs.baseUrl).host}',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
