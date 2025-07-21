import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/bloc/localeBloc/locale_bloc.dart';
import 'package:skill_bridge_mobile/core/constants/app_strings.dart';
import 'package:skill_bridge_mobile/core/routes/go_routes.dart';
import 'package:skill_bridge_mobile/features/authentication/presentation/bloc/device_token/delete_device_token_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/settings_content_entity.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/deleteAccountBloc/delete_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/logout/logout_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/select_language_widget.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/share_feedback_widget.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/text_with_icon_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showCustomBottomSheet(BuildContext context, Widget content) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      transitionAnimationController: AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: Navigator.of(context),
      ),
      builder: (BuildContext context) {
        return AnimatedPadding(
          padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: content,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showConfirmationDialog(BuildContext context) async {
      showGeneralDialog(
        transitionDuration: const Duration(milliseconds: 200),
        context: context,
        // barrierDismissible: true,
        pageBuilder: (context, animation, animation2) {
          return Container();
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: .5, end: 1.0).animate(animation),
            child: Theme(
              data: ThemeData(
                inputDecorationTheme: const InputDecorationTheme(
                  // Set the border color for TextField
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff18786a)),
                  ),
                  // Add more InputDecoration styles if needed
                ),
              ),
              child: AlertDialog(
                titleTextStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                title: const Text('Are you sure you want to logout?'),
                backgroundColor: Colors.white,
                // content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel',
                        style: TextStyle(
                            color: Color(0xff18786a), fontFamily: 'Poppins')),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text('Logout',
                        style: TextStyle(
                            color: Color(0xff18786a), fontFamily: 'Poppins')),
                    onPressed: () {
                      context
                          .read<DeleteDeviceTokenBloc>()
                          .add(const DeleteDeviceTokenEvent());
                      context.read<LogoutBloc>().add(DispatchLogoutEvent());
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    Future<void> showConfirmationDialogForDelete(BuildContext context) async {
      showGeneralDialog(
        transitionDuration: const Duration(milliseconds: 200),
        context: context,
        // barrierDismissible: true,
        pageBuilder: (context, animation, animation2) {
          return Container();
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: .5, end: 1.0).animate(animation),
            child: Theme(
              data: ThemeData(
                inputDecorationTheme: const InputDecorationTheme(
                  // Set the border color for TextField
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff18786a)),
                  ),
                  // Add more InputDecoration styles if needed
                ),
              ),
              child: AlertDialog(
                titleTextStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                title:
                    const Text('Are you sure you want to delete your account?'),
                backgroundColor: Colors.white,
                // content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel',
                        style: TextStyle(
                            color: Color(0xff18786a), fontFamily: 'Poppins')),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text('Delete',
                        style: TextStyle(
                            color: Color(0xff18786a), fontFamily: 'Poppins')),
                    onPressed: () {
                      context
                          .read<DeleteDeviceTokenBloc>()
                          .add(const DeleteDeviceTokenEvent());
                      context
                          .read<DeleteAccountBloc>()
                          .add(DispatchDeleteAccountEvent());
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<LogoutBloc, LogoutState>(
          listener: (context, state) {
            if (state is LogedOutState) {
              LoginPageRoute().go(context);
            }
          },
        ),
        BlocListener<DeleteAccountBloc, DeleteAccountState>(
          listener: (context, state) {
            if(state is DeleteAccountState){
               LoginPageRoute().go(context);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF2E2C2C),
              size: 20.0,
            ),
          ),
          title: Text(
            AppLocalizations.of(context)!.settings,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* General Settings
              Text(
                AppLocalizations.of(context)!.general,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 1.h,
              ),
              const Divider(
                height: 10,
                thickness: 0.2,
                color: Colors.grey,
              ),
              //? Language Preferences
              TextWithIconWidget(
                leading: const Icon(
                  Icons.language,
                  size: 22,
                ),
                title: AppLocalizations.of(context)!.select_language,
                subTitle: AppLocalizations.of(context)!.change_language,
                onPressed: () {
                  showCustomBottomSheet(context, const ChangeLanguageWidget());
                },
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                AppLocalizations.of(context)!.privacy,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 1.h,
              ),
              const Divider(
                height: 10,
                thickness: 0.2,
                color: Colors.grey,
              ),

              TextWithIconWidget(
                leading: const Icon(
                  Icons.lock,
                  size: 22,
                ),
                title: AppLocalizations.of(context)!.terms_and_conditions,
                subTitle:
                    AppLocalizations.of(context)!.see_terms_and_conditions,
                onPressed: () {
                  showCustomBottomSheet(
                    context,
                    TermsAndConditions(
                      conditions: termsAndCondition,
                    ),
                  );
                },
              ),
              TextWithIconWidget(
                leading: const Icon(
                  Icons.privacy_tip,
                  size: 22,
                ),
                title: AppLocalizations.of(context)!.privacy_policy,
                subTitle: AppLocalizations.of(context)!.see_privacy_policy,
                onPressed: () {
                  showCustomBottomSheet(
                    context,
                    TermsAndConditions(
                      conditions: privacyPolicy,
                    ),
                  );
                },
              ),
              // TextWithIconWidget(
              //   leading: const Icon(
              //     Icons.feedback_rounded,
              //     size: 22,
              //   ),
              //   title: 'Give us feedback',
              //   subTitle: 'Please share your experience with the app',
              //   onPressed: () {
              //     showCustomBottomSheet(context, ShareExperienceWidget());
              //   },
              // ),
              //* Logout Button
              TextWithIconWidget(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 22,
                ),
                title: AppLocalizations.of(context)!.log_out,
                titleColor: Colors.red,
                subTitle: AppLocalizations.of(context)!.log_out_confirmation,
                onPressed: () {
                  showConfirmationDialog(context);
                },
              ),
              //* Delete Account Button

              TextWithIconWidget(
                leading: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                  size: 25,
                ),
                title: 'Delete Account',
                titleColor: Colors.red,
                subTitle: 'Your account will be deleted',
                onPressed: () {
                  showConfirmationDialogForDelete(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
