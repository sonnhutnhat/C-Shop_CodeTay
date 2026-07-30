sealed class GlobalEvent {
  const GlobalEvent();
}

final class SessionExpiredEvent extends GlobalEvent {
  const SessionExpiredEvent();
}
