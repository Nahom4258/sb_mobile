import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/bloc/localeBloc/locale_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        return SizedBox(
          height: 40.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                    child: Text(AppLocalizations.of(context)!.select_language,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500))),
              ),
              SizedBox(height: 2.h),
              SingleLaguageWidget(
                title: AppLocalizations.of(context)!.english,
                isSelected: state.currentLocale == 'en',
                onTap: () {
                  context
                      .read<LocaleBloc>()
                      .add(const ChangeLocaleEvent(locale: 'en'));
                },
              ),
              SizedBox(height: 1.h),
              SingleLaguageWidget(
                title: AppLocalizations.of(context)!.amharic,
                isSelected: state.currentLocale == 'am',
                onTap: () {
                  context
                      .read<LocaleBloc>()
                      .add(const ChangeLocaleEvent(locale: 'am'));
                },
              ),
              SizedBox(height: 1.h),
              SingleLaguageWidget(
                title: AppLocalizations.of(context)!.oromifa,
                isSelected: state.currentLocale == 'or',
                onTap: () {
                  context
                      .read<LocaleBloc>()
                      .add(const ChangeLocaleEvent(locale: 'or'));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class SingleLaguageWidget extends StatelessWidget {
  const SingleLaguageWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });
  final String title;
  final bool isSelected;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 8.h,
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected
              ? const Color(0xff18786a).withOpacity(.1)
              : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xff18786a) : Colors.black12,
            width: 2.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xff18786a),
              )
          ],
        ),
      ),
    );
  }
}
