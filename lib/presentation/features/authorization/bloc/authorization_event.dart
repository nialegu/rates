part of 'authorization_bloc.dart';

@freezed
class AuthorizationEvent with _$AuthorizationEvent {
  const factory AuthorizationEvent.started() = _Started;

  const factory AuthorizationEvent.loggingIn(String login, String password) = _LoggingIn;

  const factory AuthorizationEvent.loggingOut() = _LoggingOut;
}