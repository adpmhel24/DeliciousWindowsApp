import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

import '../../../widgets/custom_dialog.dart';
import '../bloc/bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key, required this.onLoginCallback}) : super(key: key);

  final Function(bool loggedIn) onLoginCallback;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isHidden = true;

  void togglePasswordVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginFormBloc, LoginFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionInProgress) {
          showDialog(
            context: context,
            builder: (context) {
              return ContentDialog(
                content: SizedBox(
                  height: 15.r,
                  width: 15.r,
                  child: const ProgressRing(),
                ),
              );
            },
          );
        } else if (state.status.isSubmissionSuccess) {
          widget.onLoginCallback(true);
        } else if (state.status.isSubmissionFailure) {
          CustomDialog.error(context, message: state.message, actions: [
            Button(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ]);
        }
      },
      builder: (_, state) {
        return Column(
          children: [
            TextFormBox(
              autovalidateMode: AutovalidateMode.always,
              controller: _usernameController,
              header: "Username*",
              onChanged: (_) {
                context.read<LoginFormBloc>().add(
                      UsernameChanged(_usernameController),
                    );
              },
              validator: (_) {
                return context.read<LoginFormBloc>().state.username.invalid
                    ? "Required Field"
                    : null;
              },
              onFieldSubmitted: (_) {
                state.status.isValidated
                    ? context.read<LoginFormBloc>().add(ProceedLogin())
                    : null;
              },
            ),
            TextFormBox(
              autovalidateMode: AutovalidateMode.always,
              controller: _passwordController,
              header: "Password*",
              obscureText: _isHidden,
              suffix: IconButton(
                onPressed: togglePasswordVisibility,
                icon: Icon(
                  _isHidden ? FluentIcons.hide : FluentIcons.red_eye,
                ),
              ),
              onChanged: (_) {
                context.read<LoginFormBloc>().add(
                      PasswordChanged(_passwordController),
                    );
              },
              onFieldSubmitted: (_) {
                state.status.isValidated
                    ? context.read<LoginFormBloc>().add(ProceedLogin())
                    : null;
              },
              validator: (_) {
                return context.read<LoginFormBloc>().state.password.invalid
                    ? "Required Field"
                    : null;
              },
            ),
          ],
        );
      },
    );
  }
}
