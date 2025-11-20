part of 'authentication.bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, none }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    required this.status,
    this.user,
  });

  const AuthenticationState.authenticated(UserModel user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final UserModel? user;

  @override
  List<Object?> get props => [status, user];

  const AuthenticationState.none() : this._(status: AuthenticationStatus.none);
}
