import '../network/api_exception.dart';

abstract class BaseRepository {
  const BaseRepository();

  Future<T> guard<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on Object catch (error) {
      throw AppException.from(error);
    }
  }
}
