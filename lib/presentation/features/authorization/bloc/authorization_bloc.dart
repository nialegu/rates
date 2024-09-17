import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/services/auth_service.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';
part 'authorization_bloc.freezed.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final AuthService _authService = AuthService();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  AuthorizationBloc() : super(const _Initial()) {
    on<AuthorizationEvent>(_onEvent);
  }

  _onEvent(AuthorizationEvent event, Emitter<AuthorizationState> emit) async {
    await event.when(
      started: () async {
        if (await _authService.loggedIn) {
          emit(const AuthorizationState.loggedIn());
        } else {
          emit(const AuthorizationState.notLoggedIn());
        }
      },
      loggingIn: (login, password) async {
        emit(const AuthorizationState.loading());
        await _authService
            .login(login, password)
            .then((_) => emit(const AuthorizationState.loggedIn()))
            .catchError((error) => emit(AuthorizationState.authFailed(error)));
      },
      loggingOut: () async {
        emit(const AuthorizationState.loading());
        await _authService.logout();
        emit(const AuthorizationState.notLoggedIn());
      },
    );
  }
}
