import 'package:c_shop/app.dart';
import 'package:c_shop/common/app_images.dart';
import 'package:c_shop/configs/app_configs.dart';
import 'package:c_shop/configs/app_env_config.dart';
import 'package:c_shop/ui/pages/app_start/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    AppConfigs.env = Environment.dev;
  });

  testWidgets('renders the C-Shop splash screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.byType(SplashPage), findsOneWidget);

    final image = tester.widget<Image>(find.byKey(SplashPage.imageKey));
    final imageProvider = image.image as AssetImage;

    expect(imageProvider.assetName, AppImages.icSplash);
    expect(image.fit, BoxFit.cover);
  });
}
