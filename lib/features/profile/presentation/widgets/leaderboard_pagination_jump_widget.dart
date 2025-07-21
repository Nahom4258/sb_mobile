import 'package:flutter/material.dart';

class PaginationJumpButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Function() onTap;
  const PaginationJumpButton({
    super.key,
    required this.child,
    this.backgroundColor,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // ontap
      },
      child: Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xffE4E4E4),
        ),
        child: child,
      ),
    );
  }
}
