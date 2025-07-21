import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userRefferalInfoCubit/user_refferal_info_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
Future<dynamic> InviteAnAppDialog(BuildContext context, String referalLink) {
  final localization = AppLocalizations.of(context);
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.centerLeft,
          elevation: 2,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.close,
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      'assets/images/logo_3.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
               Text(
                localization!.share_skillbridge,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 23.h,
                width: 45.w,
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff1A7A6C),
                        Color(0xff73C3B7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: QrImageView(
                    data: referalLink,
                    version: QrVersions.auto,
                    size: 300.0,
                    backgroundColor: Colors.white,
                    // foregroundColor: const Color(0xff18786a),
                    // embeddedImage:
                    //     const AssetImage('assets/images/Logo.png'),
                    // embeddedImageStyle: const QrEmbeddedImageStyle(
                    //   size: Size(0, 0),
                    // ),
                    // eyeStyle: const QrEyeStyle(
                    //   eyeShape: QrEyeShape.circle,
                    //   color: Colors.white,
                    // ),
                    // padding: const EdgeInsets.all(20),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
               Text(
                localization!.share_this_qr_code_to_your_friends,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: 'Poppins', color: Colors.black54, fontSize: 18),
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Share.share(referalLink);
                    },
                    child: Container(
                      width: 30.w,
                      // alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffE9EFEF),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.share,
                            size: 22,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                           Text(
                            localization!.share,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(text: referalLink),
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 30.w,
                      // alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffE9EFEF),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.copy,
                            size: 22,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                           Text(
                            localization!.copy,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              const Divider(),
              SizedBox(height: 2.h),
              BlocBuilder<UserRefferalInfoCubit, UserRefferalInfoState>(
                builder: (context, state) {
                  if (state is UserRefferalInfoLoaded) {
                    return Row(
                      children: [
                        const Icon(
                          Icons.people,
                          color: Color(0xff18786a),
                        ),
                        SizedBox(width: 1.w),
                         Text(
                          localization!.total_referrals,
                          style: const TextStyle(
                              color: Color(0xff3B3B3B),
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          state.userRefferalInfoEntity.refferalCount.toString(),
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        );
      });
}
