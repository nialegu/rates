part of 'authorization_bloc.dart';

@freezed
class AuthorizationState with _$AuthorizationState {
  const factory AuthorizationState.initial() = _Initial;

  const factory AuthorizationState.loggedIn() = _LoggedIn;

  const factory AuthorizationState.notLoggedIn() = _NotLoggedIn;

  const factory AuthorizationState.authFailed(dynamic error) = _AuthFailed;

  const factory AuthorizationState.loading() = _Loading;
}
