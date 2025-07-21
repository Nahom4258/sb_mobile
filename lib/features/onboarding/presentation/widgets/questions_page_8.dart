import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:skill_bridge_mobile/features/onboarding/presentation/bloc/schools_bloc/schools_event.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/bloc/schoolInfoBloc/school_bloc.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/dropdown_with_userinput.dart';
import 'package:skill_bridge_mobile/features/profile/presentation/widgets/profile_dropdown_selection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/schools_bloc/schols_bloc.dart' as schols_bloc;
import '../bloc/schools_bloc/schools_state.dart' as schols_state;

class OnboardingSchoolsPage extends StatelessWidget {
  OnboardingSchoolsPage({super.key});

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<schols_bloc.SchoolBloc>()
          .add(GetSchoolsEvent(searchParam: ''));
    });
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                children: [
                   Text(
                    AppLocalizations.of(context)!.select_school_you_go_to,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/onboarding/schoolInfo.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<SchoolBloc, SchoolState>(
                  builder: (context, state) {
                    if (state is SchoolLoadedState) {
                      final schoolInfo = state.schoolDepartmentInfo.schoolInfo;
                      final regionInfo = state.schoolDepartmentInfo.regionInfo;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<schols_bloc.SchoolBloc,
                              schols_state.SchoolState>(
                            builder: (context, state) {
                              if (state is schols_state.SchoolsLoading) {
                                // Show loading indicator when schools are being fetched
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is schols_state.SchoolsLoaded ||
                                  state is schols_state.SchoolInitial) {
                                // Show dropdown when schools are successfully loaded
                                final List<String> schools =
                                    (state is schols_state.SchoolsLoaded)
                                        ? state.schools
                                            .map((e) => e.name as String)
                                            .toList()
                                        : [];
                                return DropDownWithUserInput(
                                  lable:
                                      '', // Corrected typo from 'lable' to 'label'
                                  selectedCallback: (val) {
                                    if (val != null) {
                                      context
                                          .read<OnboardingBloc>()
                                          .add(SchoolChangedEvent(school: val));
                                      return;
                                    }
                                  },
                                  title: 'High School',
                                  items: schools,
                                  hintText: 'Select your school',
                                  scrollController: scrollController,
                                );
                              } else if (state is schols_state.SchoolsError) {
                                // Show error message when there is a failure
                                return Center(
                                  child: Text('Error: ${state.message}'),
                                );
                              }

                              // Return empty container as a fallback or initial state
                              return Container();
                            },
                          ),
                          SizedBox(height: 3.h),
                          ProfileDropdownOptions(
                            lable: '',
                            selectedCallback: (val) {
                              if (val != null) {
                                context
                                    .read<OnboardingBloc>()
                                    .add(RegionChnagedEvent(region: val));
                              }
                            },
                            title: AppLocalizations.of(context)!.region,
                            items: regionInfo,
                            hintText: AppLocalizations.of(context)!.select_your_region,
                            width: 92.w,
                          ),
                          SizedBox(height: 3.h),
                          
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
