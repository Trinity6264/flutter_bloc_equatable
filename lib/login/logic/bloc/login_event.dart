part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailEvent extends LoginEvent {
  const EmailEvent({required this.val});
  final String val;
  @override
  List<Object> get props => [val];
}

class PasswordEvent extends LoginEvent {
  const PasswordEvent({required this.val});
  final String val;
  @override
  List<Object> get props => [val];
}

class LoginSubmittedEvent extends LoginEvent {
  const LoginSubmittedEvent();
}
