import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({
    super.key,
    required this.reloadCallback,
    this.setColor = false,
  });
  final Function() reloadCallback;
  final bool setColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(height: 10.h),
            Icon(
              Icons.signal_wifi_connected_no_internet_4,
              size: 32,
              color: setColor ? Colors.white : Colors.black,
            ),
            SizedBox(height: 2.h),
            Text(
              AppLocalizations.of(context)!
                  .check_your_internet_connection_and_try_again,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: setColor ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 2.h),
            InkWell(
              onTap: () {
                reloadCallback();
              },
              borderRadius: BorderRadius.circular(2.h),
              splashColor: const Color(0xff18786A).withOpacity(.1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: .7.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  color: setColor ? Colors.white : Colors.transparent,
                  border: Border.all(
                    color: setColor ? Colors.white : const Color(0xff18786a),
                  ),
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: Text(
                  AppLocalizations.of(context)!.retry,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    color: setColor ? Colors.black : const Color(0xff18786a),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
