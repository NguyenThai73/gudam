import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_user/service_user.dart';

import '../../repository/authentication.repository.dart';

part 'authentication.event.dart';
part 'authentication.state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  late final StreamSubscription<UserModel?> _userSubscription;
  UserModel? user;

  AuthenticationBloc({required this.authenticationRepository}) : super(const AuthenticationState.none()) {
    on<_AuthenticationUserChanged>(_onUserChanged);
    on<AuthenticationLogoutRequested>(_onLogoutRequested);
    _userSubscription = authenticationRepository.userForAuthen.listen(
      (user) {
        add(_AuthenticationUserChanged(user));
      },
    );
  }

  void _onUserChanged(_AuthenticationUserChanged event, Emitter<AuthenticationState> emit) {
    emit(
      event.user != null ? AuthenticationState.authenticated(event.user!) : const AuthenticationState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AuthenticationLogoutRequested event, Emitter<AuthenticationState> emit) {
    unawaited(authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
