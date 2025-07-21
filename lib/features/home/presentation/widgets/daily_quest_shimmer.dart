import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class DailyQuestCardShimmer extends StatelessWidget {
  const DailyQuestCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 1.5.h, bottom: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
            color: const Color.fromARGB(255, 118, 118, 118).withOpacity(0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[400]!,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    size: 15.0,
                    Icons.checklist,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 3.w),
                Container(
                  width: 60.w,
                  height: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Container(
                  height: 6,
                  width: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 2.w),
                Container(
                  width: 40.w,
                  height: 13,
                  color: Colors.grey[400],
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Container(
              width: double.infinity,
              height: 10,
              color: Colors.grey[400],
            ),
            SizedBox(height: 1.h),
            Container(
              width: 20.w,
              height: 13,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}