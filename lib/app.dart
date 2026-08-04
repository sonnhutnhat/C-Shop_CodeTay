import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/app_themes.dart';
import 'configs/app_configs.dart';
import 'global_blocs/setting/app_setting_cubit.dart';
import 'global_blocs/setting/app_setting_state.dart';
import 'router/route_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppSettingCubit>(
          create: (_) => AppSettingCubit()..load(),
        ),
      ],
      child: BlocBuilder<AppSettingCubit, AppSettingState>(
        buildWhen: (previous, current) => previous.language != current.language,
        builder: (context, state) {
          return GestureDetector(
            onTap: FocusManager.instance.primaryFocus?.unfocus,
            child: MaterialApp.router(
              title: AppConfigs.appName,
              debugShowCheckedModeBanner: false,
              theme: const AppThemes().theme,
              routerConfig: AppRouter.router,
              locale: state.language.locale,
              supportedLocales: const <Locale>[
                Locale('vi'),
                Locale('en'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            ),
          );
        },
      ),
    );
  }
}
