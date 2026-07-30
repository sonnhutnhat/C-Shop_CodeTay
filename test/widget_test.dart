import 'package:c_shop/app.dart';
import 'package:c_shop/configs/app_configs.dart';
import 'package:c_shop/configs/app_env_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    AppConfigs.env = Environment.dev;
  });

  testWidgets('renders C-Shop base screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('C-Shop base is ready'), findsOneWidget);
    expect(find.textContaining('DEV'), findsOneWidget);
  });
}
