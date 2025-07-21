import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/features/authentication/presentation/widgets/siginin_with_google.dart';
import 'package:skill_bridge_mobile/features/authentication/presentation/widgets/signin_with_apple.dart';
import 'package:skill_bridge_mobile/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/core.dart';
import '../../../../core/utils/snack_bar.dart';
import '../../authentication.dart';
// import '../../../../core/routes/app_routes.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailOrPhoneNumberController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  // bool _isChecked = false;
  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();
  void manageReferalData() async {
    final localDataSource = serviceLocator<AuthenticationLocalDatasource>();
    String? referalCode = await localDataSource.getReferralId();
    if (referalCode != null) {
      print('referral code: $referalCode');
    }
  }

  void clearReferalData() async {
    final localDataSource = serviceLocator<AuthenticationLocalDatasource>();
    await localDataSource.clearRefferalCode();
  }

  @override
  void dispose() {
    _emailOrPhoneNumberController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void dispatchSignup() {
    context.read<AuthenticationBloc>().add(SendOtpVerficationEvent(
          emailOrPhoneNumber: _emailOrPhoneNumberController.text.trim(),
          isForForgotPassword: false,
        ));
  }

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
      listener: (context, state) {
        if (state is SendOtpVerificationState &&
            state.status == AuthStatus.loaded) {
          // List<String> fullName = _firstNameController.text.trim().split(' ');
          // final firstName = fullName[0];
          // final lastName = fullName.length >= 2 ? fullName[1] : 'lastName';
          context.read<SignupFormBloc>().add(ChangeEmailEvent(
              email: _emailOrPhoneNumberController.text.trim()));
          context.read<SignupFormBloc>().add(ChangeFirstNameEvent(
              firstName: _firstNameController.text.trim()));
          context.read<SignupFormBloc>().add(
              ChangeLastNameEvent(lastName: _lastNameController.text.trim()));
          context
              .read<SignupFormBloc>()
              .add(ChangePassEvent(password: _passwordController.text));

          SignupOtpPageRoute(
            emailOrPhoneNumber: _emailOrPhoneNumberController.text,
          ).go(context);
          clearReferalData();
          // context.push(
          //   AppRoutes.otpPage,
          //   extra: AppRoutes.signup,
          // );
        } else if (state is SendOtpVerificationState &&
            state.status == AuthStatus.error) {
          showErrorMessage(state.errorMessage);
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
        } else if (state is SignInWithGoogleState &&
            state.status == AuthStatus.error) {
          final snackBar = SnackBar(content: Text(state.errorMessage!));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        // Sign in with Apple Bloc Listner
        else if (state is SignInWithAppleState &&
            state.status == AuthStatus.loaded) {
          final user = state.userCredential!;
          if (user.firstName == "defaultName") {
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
          final snackBar = SnackBar(content: Text(state.errorMessage!));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: signupForm(context),
    );
  }

  Scaffold signupForm(BuildContext context) {
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
                  AppLocalizations.of(context)!.let_us_get_started,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A7A6C),
                  ),
                ),
                // Text(
                //   'Start Learning today!',
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
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    hintText: AppLocalizations.of(context)!
                        .enter_your_email_or_phone_number,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
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
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.first_name,
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
                  controller: _firstNameController,
                  validator: (fullName) {
                    return validateFirstName(fullName, context);
                  },
                  cursorColor: const Color(0xFF18786A),
                  onChanged: (value) {
                    if (_formKey.currentState != null) {
                      _formKey.currentState!
                          .validate(); // Re-trigger validation when the text changes
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    hintText:
                        AppLocalizations.of(context)!.enter_your_first_name,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
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
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.last_name,
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
                  controller: _lastNameController,
                  validator: (fullName) {
                    return validateLastName(fullName, context);
                  },
                  cursorColor: const Color(0xFF18786A),
                  onChanged: (value) {
                    if (_formKey.currentState != null) {
                      _formKey.currentState!.validate();
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    hintText:
                        AppLocalizations.of(context)!.enter_your_last_name,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
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
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 20),
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
                  validator: (value) {
                    return validatePassword(value, context);
                  },
                  obscureText: !_passwordVisible,
                  cursorColor: const Color(0xFF18786A),
                  onChanged: (value) {
                    if (_formKey.currentState != null) {
                      _formKey.currentState!.validate();
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    hintText: AppLocalizations.of(context)!.enter_your_password,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
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
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 20),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       _isChecked = !_isChecked;
                //     });
                //   },
                //   child: Row(
                //     children: [
                //       CustomCheckBox(
                //         isChecked: _isChecked,
                //         onTap: () {
                //           setState(() {
                //             _isChecked = !_isChecked;
                //           });
                //         },
                //       ),
                //       const SizedBox(width: 8),
                //       Text(
                //         'I agree to the terms and conditions',
                //         style: GoogleFonts.poppins(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w500,
                //           color: const Color(0xFF363636),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          manageReferalData();
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Perform further actions with the valid input

                            dispatchSignup();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF18786A),
                          foregroundColor: const Color(0xFFFFFFFF),
                          minimumSize: Size(double.infinity, 5.8.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.sign_up,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFFFFFF),
                          ),
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
                  SignInWithAppleWidget(text: 'Continue with Apple')
                //? This comment is intentional, it is needed for the next MVP
                // const SizedBox(height: 24),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(
                //       width: 100,
                //       height: 1,
                //       color: const Color(0xFFC5C5C5),
                //     ),
                //     Text(
                //       'or Sign Up With',
                //       style: GoogleFonts.poppins(
                //         fontSize: 14,
                //         fontWeight: FontWeight.w500,
                //         color: const Color(0xFF363636),
                //       ),
                //     ),
                //     Container(
                //       width: 100,
                //       height: 1,
                //       color: const Color(0xFFC5C5C5),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 24),
                // Row(
                //   children: [
                //     Expanded(
                //       child: OutlinedButton(
                //         onPressed: () {
                //           context
                //               .read<AuthenticationBloc>()
                //               .add(SignInWithGoogleEvent());
                //         },
                //         style: OutlinedButton.styleFrom(
                //           padding: const EdgeInsets.symmetric(
                //               horizontal: 16, vertical: 12),
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(12),
                //           ),
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Image.asset(
                //               'assets/images/google_icon.png',
                //               width: 20,
                //               height: 20,
                //             ),
                //             const SizedBox(width: 14),
                //             Text(
                //               'Google',
                //               style: GoogleFonts.poppins(
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w500,
                //                 color: const Color(0xFF363636),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.already_have_an_account,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF363636),
                      ),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {
                        // context.go(AppRoutes.login);
                        LoginPageRoute().go(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
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
