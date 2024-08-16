import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String phoneNumber;
  final String verificationId;

  const Auth({required this.phoneNumber, required this.verificationId});

  @override
  List<Object?> get props => [phoneNumber, verificationId];
}
