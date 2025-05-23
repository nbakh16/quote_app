import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_app/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:quote_app/features/home/presentation/home_page.dart';
import 'package:quote_app/widgets/custom_textfield.dart';
import 'package:quote_app/widgets/loading_dialog.dart';
import 'package:quote_app/widgets/my_snackbar.dart';

class AuthPage extends StatefulWidget {
  static const routeName = 'auth';
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailTEC = TextEditingController();
  final passwordTEC = TextEditingController();
  final confPasswordTEC = TextEditingController();
  bool isRegistration = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is Loading) {
              LoadingDialog.show(context);
            } else {
              LoadingDialog.hide(context);
            }

            if (state is AuthSuccess) {
              context.goNamed(
                HomePage.routeName,
                extra: state.userEmail.toString(),
              );
            }

            if (state is Error) {
              mySnackBar(context, message: state.message);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Text(isRegistration ? 'Registration' : 'Login',
                      style: textTheme.displaySmall),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: emailTEC,
                    prefixIcon: const Icon(Icons.mail_outline,
                        color: Color(0xff7A7A7A)),
                    hintText: 'Email',
                    extraLabel: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextField(
                    controller: passwordTEC,
                    prefixIcon: const Icon(Icons.key_outlined,
                        color: Color(0xff7A7A7A)),
                    hintText: 'Password',
                    extraLabel: 'Password',
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: isRegistration
                        ? CustomTextField(
                            controller: confPasswordTEC,
                            prefixIcon: const Icon(Icons.key_outlined,
                                color: Color(0xff7A7A7A)),
                            hintText: 'Confirm Password',
                            extraLabel: 'Confirm Password',
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          )
                        : SizedBox.shrink(),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      String email = emailTEC.text.trim();
                      String password = passwordTEC.text;
                      String confPassword = confPasswordTEC.text;

                      if (email.isEmpty || password.isEmpty) {
                        mySnackBar(context,
                            message: 'Email & Password required');
                        return;
                      }

                      if (isRegistration && password != confPassword) {
                        mySnackBar(context,
                            message: "Confirm password didn't match");
                        return;
                      }

                      if (isRegistration) {
                        context.read<AuthCubit>().register(
                              email: email,
                              password: password,
                            );
                      } else {
                        context.read<AuthCubit>().login(
                              email: email,
                              password: password,
                            );
                      }
                    },
                    child: Text(isRegistration ? 'Register' : 'Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isRegistration = !isRegistration;
                      });
                    },
                    child: Text(isRegistration
                        ? 'Have Account? Login'
                        : 'No Account? Register'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
