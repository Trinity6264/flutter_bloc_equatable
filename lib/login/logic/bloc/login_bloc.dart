import 'dart:async';
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:just/login/model/email.dart';
import 'package:just/login/model/password.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<EmailEvent>(emailChanged);
    on<PasswordEvent>(passwordChanged);
    on<LoginSubmittedEvent>(onSubmitted);
  }

  void emailChanged(EmailEvent event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.val);
    emit(
      state.copyWith(
        email: email,
        password: state.password,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(PasswordEvent event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.val);
    emit(
      state.copyWith(
        email: state.email,
        password: password,
        status: Formz.validate([password, state.email]),
      ),
    );
  }

  Future<void> onSubmitted(
    LoginSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      log(state.toString());
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await Future.delayed(const Duration(seconds: 3));
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
