import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../features/features.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    super.key,
    this.title,
    required this.message,
    this.width,
    this.height,
    this.reloadCallBack,
    this.showImage = true,
    this.textColor,
    required this.icon,
  });

  final String? title;
  final String message;
  final double? width;
  final double? height;
  final Function? reloadCallBack;
  final bool showImage;
  final Color? textColor;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showImage)
          Center(
            child: SvgPicture.asset(
            icon,
            
                    ),
          ),
        const SizedBox(height: 8),
        reloadCallBack == null
            ? Text(
                title ?? 'Empty',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color:Color(0xff18786a) ,
                ),
              )
            : IconButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(const Color(0xFF18786A)),
                ),
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  // size: 18,
                ),
                onPressed: () {
                  reloadCallBack!();
                },
              ),

        // InkWell(
        //     onTap: () {
        //       reloadCallBack!();
        //     },
        //     child: Container(
        //       padding:
        //           const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        //       decoration: BoxDecoration(
        //         color: const Color(0xFF18786A),
        //         borderRadius: BorderRadius.circular(4),
        //       ),
        //       child: Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           const Icon(Icons.refresh, color: Colors.white, size: 18),
        //           // const SizedBox(width: 6),
        //           // Text(
        //           //   'Refresh',
        //           //   style: GoogleFonts.poppins(
        //           //     color: Colors.white,
        //           //   ),
        //           // ),
        //         ],
        //       ),
        //     ),
        //   ),
        const SizedBox(height: 8),
        Text(
          textAlign: TextAlign.center,
          message,
          style: GoogleFonts.poppins(
            color: textColor ?? const Color(0xFF797979),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
