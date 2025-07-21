import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/features.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/department_entity.dart';
import 'package:skill_bridge_mobile/features/profile/domain/entities/profile_update_entity.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/changePasswordBloc/password_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/changePasswordBloc/password_event.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/changePasswordBloc/password_state.dart';

import 'package:skill_bridge_mobile/features/profile/presentation/bloc/changeUsernameBloc/username_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/changeUsernameBloc/username_event.dart';

import 'package:skill_bridge_mobile/features/profile/presentation/bloc/changeUsernameBloc/username_state.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/schoolInfoBloc/school_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userProfile/userProfile_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/userProfile/userProfile_event.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/dropdown_with_userinput.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/menu_icon.dart';

import 'package:skill_bridge_mobile/features/profile/presentation/widgets/name_editing_field.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/profile_dropdown_selection.dart';
import '../../../../core/utils/snack_bar.dart';
import '../widgets/custom_text_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirstName extends StatefulWidget {
  const FirstName({super.key});

  @override
  State<FirstName> createState() => _FirstNameState();
}

class _FirstNameState extends State<FirstName> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
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
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFC),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          height: 100.h,
          child: MultiBlocListener(
            listeners: [
              BlocListener<UsernameBloc, UsernameState>(
                listener: (context, state) {
                  if (state is UserProfileUpdatedState) {
                    return OnboardingQuestionPagesRoute().go(context);
                  } else if (state is UpdateProfileFailedState) {
                    if (state.failureType is RequestOverloadFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          snackBar(state.failureType.errorMessage));
                    }
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Error',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.red,
                                fontWeight: FontWeight.w500),
                          ),
                          content: const Text(
                            "Update is not successful. Please try again.",
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 16),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        // child: Image.asset(
                        //   'assets/images/logologin.png',
                        //   width: 150,
                        //   height: 150,
                        // ),
                        child: Icon(Icons.warning_amber_rounded,color: Colors.amber[500],size: 70,),
                      ),
                      
                      Column(children: [
                        SizedBox(height: 20,),
                        Text(
                          'Complete Your Profile',
                          style: TextStyle(
                              color: const Color(0xFF1A7A6C),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        // Icon(Icons.warning_amber_rounded,color: Colors.amber[500],),
                        SizedBox(height: 5,),
                        Text(
                          'Please enter your real first and last name. Using your real name helps create a positive and trustworthy experience for every student in the platform.'
                          ,style:TextStyle(    
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300
                          ),
                          textAlign: TextAlign.center, 
                        )
                      ]),
                      SizedBox(height: 5.h),
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
                          controller: firstNameController,
                          cursorColor: const Color(0xFF18786A),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            hintText: AppLocalizations.of(context)!.first_name,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
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
                      SizedBox(
                        height: 2.h,
                      ),
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
                          controller: lastNameController,
                          cursorColor: const Color(0xFF18786A),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            hintText: AppLocalizations.of(context)!.last_name,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 3.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.read<UsernameBloc>().add(
                                        UpdateProfileEvent(
                                          updateEntity: ProfileUpdateEntity(
                                              firstName:
                                                  firstNameController.text,
                                              lastName:
                                                  lastNameController.text),
                                        ),
                                      );
                                  print("Here too");
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff18786a),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:
                                      BlocBuilder<UsernameBloc, UsernameState>(
                                    builder: (context, state) {
                                      if (state is ProfileUpdateOnProgress) {
                                        return const CustomProgressIndicator(
                                          color: Colors.white,
                                          size: 20,
                                        );
                                      }
                                      return const Text(
                                        'Save',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins'),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
