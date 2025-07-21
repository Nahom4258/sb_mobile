import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RequestsTabWidget extends StatelessWidget {
  final int number;
  final String title;
  final bool selected;

  const RequestsTabWidget({
    super.key,
    required this.number,
    required this.title,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        border: Border.all(
            color: selected ? const Color(0xff18786a) : Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: selected ? const Color(0xff18786a) : Colors.grey),
            child: Text(
              number.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            title,
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }
}
