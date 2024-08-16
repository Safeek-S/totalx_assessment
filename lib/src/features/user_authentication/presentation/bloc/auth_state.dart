abstract class AuthState {
  final bool isLoading;

  AuthState({this.isLoading = false});
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  AuthLoading() : super(isLoading: true);
}

class OtpSent extends AuthState {
  final String verificationId, phoneNumber;

  OtpSent({required this.verificationId, required this.phoneNumber}) : super(isLoading: false);
}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String? message;

  AuthError({this.message}) : super(isLoading: false);
}

class OtpCountdownState extends AuthState {
  final int remainingTime;

  OtpCountdownState(this.remainingTime);

  List<Object?> get props => [remainingTime];
}
