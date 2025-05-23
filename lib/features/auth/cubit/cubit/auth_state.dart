part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class Initial extends AuthState {}

class Loading extends AuthState {}

class AuthSuccess extends AuthState {
  final String userEmail;
  const AuthSuccess({required this.userEmail});
}

class Error extends AuthState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}
