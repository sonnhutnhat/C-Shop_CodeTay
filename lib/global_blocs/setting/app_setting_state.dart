import 'package:equatable/equatable.dart';

import '../../models/enums/business_type.dart';
import '../../models/enums/language.dart';

class AppSettingState extends Equatable {
  const AppSettingState({
    this.language = Language.vietnamese,
    this.businessType = BusinessType.retail,
  });

  final Language language;
  final BusinessType businessType;

  AppSettingState copyWith({
    Language? language,
    BusinessType? businessType,
  }) {
    return AppSettingState(
      language: language ?? this.language,
      businessType: businessType ?? this.businessType,
    );
  }

  @override
  List<Object?> get props => <Object?>[language, businessType];
}
