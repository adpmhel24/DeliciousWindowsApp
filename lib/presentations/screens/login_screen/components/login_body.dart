import 'package:delicious_windows_app/presentations/screens/login_screen/bloc/login_form_bloc.dart';
import 'package:delicious_windows_app/presentations/screens/login_screen/bloc/login_form_event.dart';
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
      child: material.ListView(
        children: [
          SizedBox(height: 50.r),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 400.w,
              height: 450.h,
              child: Acrylic(
                luminosityAlpha: .1,
                tintAlpha: 1,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200.h,
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
