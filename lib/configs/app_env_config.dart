enum Environment {
  dev,
  stg,
  prod;

  String get envName => switch (this) {
        Environment.dev => 'DEV',
        Environment.stg => 'STAGING',
        Environment.prod => 'PROD',
      };

  String get baseUrl => switch (this) {
        Environment.dev => const String.fromEnvironment(
            'CSHOP_DEV_BASE_URL',
            defaultValue: 'https://api-smartbiz.cmcuat.cloud/cshop',
          ),
        Environment.stg => const String.fromEnvironment(
            'CSHOP_STAGING_BASE_URL',
            defaultValue: 'https://api-smartbiz.cmcuat.cloud/cshop',
          ),
        Environment.prod => const String.fromEnvironment(
            'CSHOP_PROD_BASE_URL',
            defaultValue: 'https://api-smartbiz.cmcuat.cloud/cshop',
          ),
      };
}
