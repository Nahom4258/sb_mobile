import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/features/authentication/presentation/widgets/siginin_with_google.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skill_bridge_mobile/features/authentication/presentation/widgets/signin_with_apple.dart';

import '../../../../core/constants/app_keys.dart';
import '../../../../core/core.dart';
import '../../../../core/utils/snack_bar.dart';
import '../../authentication.dart';
import '../presentation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailOrPhoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailOrPhoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void dispatchLogin() {
    context.read<AuthenticationBloc>().add(
          LoginEvent(
              emailOrPhoneNumber: _emailOrPhoneNumberController.text.trim(),
              password: _passwordController.text,
              rememberMe: _rememberMe,
              context: context),
        );
  }

  void storeDeviceToken() async {}
  void showErrorMessage(String? message) {
    final snackBar = SnackBar(
      content: Text(
        message ?? 'Unknow error happened, please try again.',
        style: GoogleFonts.poppins(
          color: Colors.white,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color.fromARGB(255, 172, 68, 61),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (_, state) {
        if (state is LoggedInState && state.status == AuthStatus.loaded) {
          context.read<StoreDeviceTokenBloc>().add(
                const StoreDeviceTokenEvent(),
              );
          HomePageRoute().go(context);
          // context.go(AppRoutes.myhomePage);
        } else if (state is LoggedInState && state.status == AuthStatus.error) {
          // ScaffoldMessenger.of(context).showSnackBar(snackBar(state.failure!.errorMessage));
          showErrorMessage(state.failure!.errorMessage);
        }
        // SignIn with Google Bloc Listener
        else if (state is SignInWithGoogleState &&
            state.status == AuthStatus.loaded) {
          final user = state.userCredential!;
          if (user.department != null) {
            context.read<StoreDeviceTokenBloc>().add(
                  const StoreDeviceTokenEvent(),
                );
            HomePageRoute().go(context);
          } else {
            OnboardingQuestionPagesRoute().go(context);
          }
        } else if (state is SignInWithAppleState &&
            state.status == AuthStatus.loaded) {
          final user = state.userCredential!;
          if (user.firstName == 'defaultName') {
            FirstNamePageRoute().go(context);
          } else {}
          if (user.department != null) {
            context.read<StoreDeviceTokenBloc>().add(
                  const StoreDeviceTokenEvent(),
                );
            HomePageRoute().go(context);
          } else {
            OnboardingQuestionPagesRoute().go(context);
          }
        } else if (state is SignInWithAppleState &&
            state.status == AuthStatus.error) {
          showErrorMessage(state.errorMessage);
        }
      },
      child: loginForm(context),
    );
  }

  Scaffold loginForm(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          // height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logologin.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${AppLocalizations.of(context)!.hi_welcome_back}👋',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A7A6C),
                  ),
                ),
                // Text(
                //   'Hello again, you\'ve been missed!',
                //   style: GoogleFonts.poppins(
                //     fontSize: 13,
                //     fontWeight: FontWeight.w500,
                //     color: const Color(0xFFA3A2B1),
                //   ),
                // ),
                const SizedBox(height: 24),
                Text(
                  AppLocalizations.of(context)!.email_or_phone_number,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF363636),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFormField(
                    controller: _emailOrPhoneNumberController,
                    validator: (emailOrPhoneNumber) {
                      return validateEmailOrPhoneNumber(
                          emailOrPhoneNumber, context);
                    },
                    cursorColor: const Color(0xFF18786A),
                    onChanged: (value) {
                      if (_formKey.currentState != null) {
                        _formKey.currentState!.validate();
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      hintText: AppLocalizations.of(context)!
                          .enter_your_email_or_phone_number,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Color(0xFF18786A),
                          width: 2,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                        color: Color(0xFF363636),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Poppins')),
                const SizedBox(height: 24),
                Text(
                  AppLocalizations.of(context)!.password,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF363636),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFormField(
                    controller: _passwordController,
                    validator: (password) {
                      return validatePassword(password, context);
                    },
                    obscureText: !_passwordVisible,
                    cursorColor: const Color(0xFF18786A),
                    onChanged: (value) {
                      if (_formKey.currentState != null) {
                        _formKey.currentState!.validate();
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      hintText:
                          AppLocalizations.of(context)!.enter_your_password,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Color(0xFF18786A),
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFF18786A),
                        ),
                      ),
                    ),
                    style: const TextStyle(
                        color: Color(0xFF363636),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Poppins')),
                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      _rememberMe = !_rememberMe;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // CustomCheckBox(
                      //   isChecked: _rememberMe,
                      //   onTap: () {
                      //     setState(() {
                      //       _rememberMe = !_rememberMe;
                      //     });
                      //   },
                      // ),
                      // const SizedBox(width: 8),
                      // Text(
                      //   'Remember Me',
                      //   style: GoogleFonts.poppins(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w500,
                      //     color: const Color(0xFF363636),
                      //   ),
                      // ),

                      InkWell(
                        onTap: () {
                          ForgotPasswordPageRoute().go(context);
                          // context.push(AppRoutes.forgotPassword);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.forgot_password,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFF6652),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            dispatchLogin();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF18786A),
                            foregroundColor: const Color(0xFFFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(double.infinity, 5.8.h)),
                        child: BlocBuilder<AuthenticationBloc,
                            AuthenticationState>(
                          builder: (context, loginState) {
                            if (loginState is LoggedInState &&
                                loginState.status == AuthStatus.loading) {
                              return const CustomProgressIndicator(
                                size: 16,
                                color: Colors.white,
                              );
                            }
                            return Text(
                              AppLocalizations.of(context)!.login,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFFFFFFF),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'or continue with',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                            fontSize: 13),
                      ),
                    ),
                    const Expanded(
                      child: Divider(),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SignInWithGoogleWidget(
                  text: AppLocalizations.of(context)!.sign_in_with_google,
                ),
                const SizedBox(height: 10),

                if (Platform.isIOS)
                  SignInWithAppleWidget(
                    text: 'Countinue with Apple',
                  ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.do_not_have_an_account,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF363636),
                      ),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {
                        context.go(AppRoutes.signup);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.sign_up,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF18786A),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
