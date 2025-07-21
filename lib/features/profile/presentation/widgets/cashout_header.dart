import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/externalUsersBloc/external_userProfile_state.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userProfile/userProfile_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userProfile/userProfile_state.dart';

class CashoutHeaderSection extends StatelessWidget {
  const CashoutHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff1A7A6C),
            Color(0xff5DB6A9),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.keyboard_backspace_outlined,
                  size: 22,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Cashout',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu, color: Colors.transparent)),
            ],
          ),
          SizedBox(height: 3.h),
          const Text(
            'Available Cash',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 1.h),
          BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return Column(
                  children: [
                    Text(
                      '${state.userProfile.coins.toStringAsFixed(2)} ETB',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Coin.png',
                          height: 25,
                          width: 25,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          '${state.userProfile.coins.toStringAsFixed(1)} Coins',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return SizedBox(height: 10.h);
            },
          ),
          SizedBox(height: 3.h),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CashoutButtons(
                icon: 'assets/images/cashoutDollar.png',
                text: 'Cashout',
              ),
              CashoutButtons(
                icon: 'assets/images/cashoutInfo.png',
                text: 'Account Info',
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CashoutButtons extends StatelessWidget {
  const CashoutButtons({
    super.key,
    required this.icon,
    required this.text,
  });
  final String icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 6.h,
      width: 38.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffDBDBDB),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 25,
            width: 25,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 2.w),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
