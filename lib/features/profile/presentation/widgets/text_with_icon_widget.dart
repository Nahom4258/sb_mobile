import 'package:flutter/material.dart';

class TextWithIconWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Widget? leading;
  final String subTitle;
  final Color titleColor;
  final Color subtitleColor;
  const TextWithIconWidget({
    super.key,
    required this.onPressed,
    required this.title,
    required this.subTitle,
    this.leading,
    this.titleColor = Colors.black,
    this.subtitleColor = Colors.black87,
  });
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      onTap: onPressed,
      leading: leading,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins'
        ),
        
      ),
      trailing: Icon(
        Icons.chevron_right,
        size: screenHeight * 0.021,
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13.0,
          fontWeight: FontWeight.w300
        ),
        
      ),
    );
  }
}