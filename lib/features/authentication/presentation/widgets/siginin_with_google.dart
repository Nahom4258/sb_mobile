import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/constants/app_images.dart';
import 'package:skill_bridge_mobile/core/widgets/progress_indicator.dart';
import 'package:skill_bridge_mobile/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignInWithGoogleWidget extends StatelessWidget {
  const SignInWithGoogleWidget({
    required this.text,
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AuthenticationBloc>().add(SignInWithGoogleEvent());
      },
      child: Container(
        height: 5.8.h,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 7.w,
              child: SvgPicture.asset(
                googleIcon,
                
              ),
            ),
            SizedBox(width: 16,),
            Text(
              text,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if ((state is SendOtpVerificationState &&
                        state.status == AuthStatus.loading) ||
                    (state is SignInWithGoogleState &&
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
