import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  const SessionEntity({
    required this.tenantId,
    required this.storeId,
    required this.userId,
    this.storeName = '',
  });

  factory SessionEntity.fromJson(Map<String, dynamic> json) {
    return SessionEntity(
      tenantId: json['tenant_id'] as String? ?? '',
      storeId: json['store_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      storeName: json['store_name'] as String? ?? '',
    );
  }

  final String tenantId;
  final String storeId;
  final String userId;
  final String storeName;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tenant_id': tenantId,
        'store_id': storeId,
        'user_id': userId,
        'store_name': storeName,
      };

  @override
  List<Object?> get props => <Object?>[tenantId, storeId, userId, storeName];
}
