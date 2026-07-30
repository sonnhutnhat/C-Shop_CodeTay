enum BusinessType {
  retail,
  fnb,
  service;

  String get apiValue => switch (this) {
        BusinessType.retail => 'RETAIL',
        BusinessType.fnb => 'FOOD_AND_BEVERAGE',
        BusinessType.service => 'SERVICE',
      };

  static BusinessType fromApi(String? value) {
    return switch ((value ?? '').trim().toUpperCase()) {
      'FOOD_AND_BEVERAGE' || 'F&B' || 'FNB' => BusinessType.fnb,
      'SERVICE' => BusinessType.service,
      _ => BusinessType.retail,
    };
  }
}
