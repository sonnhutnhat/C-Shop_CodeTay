import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/share_preferences_helper.dart';
import '../../models/enums/business_type.dart';
import '../../models/enums/language.dart';
import 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  AppSettingCubit() : super(const AppSettingState());

  Future<void> load() async {
    final results = await Future.wait<Object>([
      SharedPreferencesHelper.getLanguage(),
      SharedPreferencesHelper.getBusinessType(),
    ]);
    emit(
      AppSettingState(
        language: results[0] as Language,
        businessType: results[1] as BusinessType,
      ),
    );
  }

  Future<void> setLanguage(Language language) async {
    await SharedPreferencesHelper.setLanguage(language);
    emit(state.copyWith(language: language));
  }

  Future<void> setBusinessType(BusinessType businessType) async {
    await SharedPreferencesHelper.setBusinessType(businessType);
    emit(state.copyWith(businessType: businessType));
  }
}
