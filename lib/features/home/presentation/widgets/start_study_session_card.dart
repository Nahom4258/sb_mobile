import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/widgets/animated_dragable_widget.dart';

class StartStudySessionCard extends StatelessWidget {
  const StartStudySessionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: const Color(0xFF18786C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Container(
            width: 50.w,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Start a Study Session', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),),
                const SizedBox(height: 2),
                Text('Set aside time to study the subject you want.', style: GoogleFonts.poppins(color: Colors.white),),
                const SizedBox(height: 4),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    backgroundColor: const Color(0xFFFCBE05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    )
                  ),
                  onPressed: (){},
                  child: Text('Start Now', style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -12.w,
            right: -15.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/stack of books.png'),
                CircleAvatar(radius: 30.w, backgroundColor: Colors.white.withOpacity(.09),),
                CircleAvatar(radius: 24.w, backgroundColor: Colors.white.withOpacity(0.11),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
