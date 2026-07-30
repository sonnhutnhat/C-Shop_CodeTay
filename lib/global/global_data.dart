import '../models/entities/session_entity.dart';

abstract final class GlobalData {
  static SessionEntity? session;

  static void clear() {
    session = null;
  }
}
