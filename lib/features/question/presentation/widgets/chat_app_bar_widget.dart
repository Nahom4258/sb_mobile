import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatAppBarWidget extends StatelessWidget {
  const ChatAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    // color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'AI Assistant Bot',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                )
                // SizedBox(
                //   width: 48,
                //   height: 48,
                //   child: Image.asset('assets/images/profile_avatar.png'),
                // ),
                // const SizedBox(width: 12),
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Professor LearnAlot',
                //         style: GoogleFonts.poppins(
                //           fontSize: 18,
                //           fontWeight: FontWeight.w600,
                //           color: Colors.white,
                //         ),
                //       ),
                //       Text(
                //         'How can I assist you today?',
                //         maxLines: 2,
                //         overflow: TextOverflow.ellipsis,
                //         style: GoogleFonts.poppins(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const Icon(
                //   Icons.info_outline_rounded,
                //   color: Colors.white,
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
