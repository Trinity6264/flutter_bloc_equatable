import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:just/login/logic/bloc/login_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formz')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            EmailInput(),
            SizedBox(height: 20),
            PasswordInput(),
            SizedBox(height: 20),
            LoginButton(),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    ///BlocBuilder widgets are used to wrap each of the TextField widgets and make use of the buildWhen property in order to optimize for rebuilds. The onChanged callback is used to notify the LoginBloc of changes to the username/password.
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: TextStyle(color: state.email.valid ? null : Colors.red),
            ),
            const SizedBox(height: 10),
            TextField(
              key: const Key('loginForm_usernameInput_textField'),
              onChanged: (val) =>
                  context.read<LoginBloc>().add(EmailEvent(val: val)),
              decoration: InputDecoration(
                // labelText: 'Email',
                focusColor: Colors.amber,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1500),
                  borderSide: const BorderSide(color: Colors.amber),
                ),
                enabled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1500),
                  borderSide: const BorderSide(
                    color: Colors.green,
                  ),
                ),
                errorText: state.email.invalid ? 'invalid Email' : null,
                helperText: 'invalid Email',
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1500),
                  // borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(PasswordEvent(val: password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
            helperText: 'Play',
            filled: true,
            fillColor: Colors.grey,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
          ),
        );
      },
    );
  }
}

///The _LoginButton widget is only enabled if the status of the form is VALID and a CircularProgressIndicator is shown in its place while the form is being submitted.
class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                // key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        context
                            .read<LoginBloc>()
                            .add(const LoginSubmittedEvent());
                      }
                    : null,
                child: const Text('Login'),
              );
      },
    );
  }
}
