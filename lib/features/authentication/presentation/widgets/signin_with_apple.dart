import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/constants/app_images.dart';
import 'package:skill_bridge_mobile/core/widgets/progress_indicator.dart';
import 'package:skill_bridge_mobile/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignInWithAppleWidget extends StatelessWidget {
  const SignInWithAppleWidget({
    required this.text,
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AuthenticationBloc>().add(SignInWithAppleEvent());
      },
      child: Container(
        height: 5.8.h,
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(10)),
        // padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10.w,
              child: SvgPicture.asset(
                appleIcon,
                color: Colors.white,
                height: 25.0,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if ((state is SendOtpVerificationState &&
                        state.status == AuthStatus.loading) ||
                    (state is SignInWithAppleState &&
                        state.status == AuthStatus.loading)) {
                  return const CustomProgressIndicator(
                    size: 14,
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
