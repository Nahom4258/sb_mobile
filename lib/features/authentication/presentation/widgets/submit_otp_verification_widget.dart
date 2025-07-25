import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class SubmitOTPVerificationWidget extends StatelessWidget {
  const SubmitOTPVerificationWidget({
    super.key,
    required this.dispatchOtp,
    required this.prevPage,
  });

  final Function(String) dispatchOtp;
  final String prevPage;

  @override
  Widget build(BuildContext context) {
    if (prevPage == AppRoutes.signup) {
      return BlocBuilder<SignupFormBloc, SignupForm>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              dispatchOtp(state.emailOrPhoneNumber);
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
              'Submit',
              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFFFFFFF),
                                ),
            ),
          );
        },
      );
    } else {
      return BlocBuilder<ChangePasswordFormBloc, ChangePasswordForm>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              dispatchOtp(state.emailOrPhoneNumber);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF18786A),
              foregroundColor: const Color(0xFFFFFFFF),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Submit',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      );
    }
  }
}
