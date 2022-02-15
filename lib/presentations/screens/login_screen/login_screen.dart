import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/login_form_bloc.dart';
import './components/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.onLoginCallback})
      : super(key: key);

  final Function(bool loggedIn) onLoginCallback;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginFormBloc(),
      child: LoginBody(onLoginCallback: onLoginCallback),
    );
  }
}
