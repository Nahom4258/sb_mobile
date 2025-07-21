import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomepageStatsCard extends StatelessWidget {
  const HomepageStatsCard({
    super.key,
    required this.title,
    required this.stat,
    required this.description,
    required this.assetImage,
    required this.isLeft,
  });
  final String title;
  final String stat;
  final String description;
  final String assetImage;
  final bool isLeft;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: isLeft ?const Radius.circular(10.0): const Radius.circular(0.0),bottomRight: isLeft ?const Radius.circular(0.0): const Radius.circular(10.0))
        ),
        height: 8.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetImage,
              height: 5.h,
              width: 8.w,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 4.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff363636)),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: stat,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'Poppins')),
                      TextSpan(
                          text: description,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: 'Poppins'))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
