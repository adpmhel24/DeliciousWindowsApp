import '/presentations/screens/login_screen/bloc/login_form_bloc.dart';
import '/presentations/screens/login_screen/bloc/login_form_event.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_form.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key, required this.onLoginCallback}) : super(key: key);
  final Function(bool loggedIn) onLoginCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFDEF8E8),
      child: ListView(
        children: [
          SizedBox(height: 100.h),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 400.0,
              height: 550.0,
              child: Acrylic(
                luminosityAlpha: .1,
                tintAlpha: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      const Divider(),
                      SizedBox(height: 20.h),
                      LoginForm(onLoginCallback: onLoginCallback),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        height: 30.h,
                        child: material.ElevatedButton(
                          style: material.ButtonStyle(
                            backgroundColor:
                                material.MaterialStateProperty.all<Color>(
                                    const Color.fromARGB(255, 247, 209, 74)),
                          ),
                          onPressed: context
                                  .watch<LoginFormBloc>()
                                  .state
                                  .status
                                  .isValidated
                              ? () {
                                  context
                                      .read<LoginFormBloc>()
                                      .add(ProceedLogin());
                                }
                              : null,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                color: Colors.red,
                                fontFamily:
                                    GoogleFonts.merriweather().fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
