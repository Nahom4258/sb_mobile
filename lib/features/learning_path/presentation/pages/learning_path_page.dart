import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LearningPathPage extends StatelessWidget {
  const LearningPathPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: 70.w,
          child: ListView.separated(
            itemCount: 24,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
             if(index % 2 == 0) {
               return _leftAlignedNode();
             } else {
               return _rightAlignedNode();
             }
            }
          ),
        ),
      ),
    );
  }

  Widget _leftAlignedNode() {
    return Column(
      children: [
        CustomPaint(
          size: const Size(300, 300),
          painter: BrokenLinePainter(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start ,
          children: [
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 6)
                  )
                ],
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFF18786C),
                child: Icon(Icons.menu_book, color: Colors.white),
              ),
            ),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cell Biology', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                Text('10 min', style: GoogleFonts.poppins(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _rightAlignedNode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Cell Biology', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            Text('10 min', style: GoogleFonts.poppins(color: Colors.grey)),
          ],
        ),
        const SizedBox(width: 6),
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 6)
              )
            ],
            shape: BoxShape.circle,
          ),
          child: const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFF18786C),
            child: Icon(Icons.menu_book, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// class BrokenLinePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.blue
//       ..strokeWidth = 3
//       ..style = PaintingStyle.stroke;
//
//     Path path = Path();
//
//     // Starting point
//     path.moveTo(20, size.height / 2);
//
//     // Draw a curve
//     path.quadraticBezierTo(
//       size.width * 0.25, size.height * 0.25, // Control point
//       size.width * 0.5, size.height / 2,     // End point of the curve
//     );
//
//     // Break in the line (you can skip this by not adding any path)
//
//     // Continue with another curve (broken line effect)
//     path.moveTo(size.width * 0.5, size.height / 2); // Start again from middle
//     path.quadraticBezierTo(
//       size.width * 0.75, size.height * 0.75, // Control point
//       size.width, size.height / 2,           // End point of the curve
//     );
//
//     // Draw the path
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

class BrokenLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    Path path = Path();

    // First curve
    path.moveTo(20, size.height / 2);
    path.quadraticBezierTo(
      size.width * 0.2, size.height * 0.4,
      size.width * 0.4, size.height / 2,
    );

    // Break (moving without drawing)
    path.moveTo(size.width * 0.4, size.height / 2);

    // Second curve
    path.quadraticBezierTo(
      size.width * 0.6, size.height * 0.6,
      size.width * 0.8, size.height / 2,
    );

    // Break (moving without drawing)
    path.moveTo(size.width * 0.8, size.height / 2);

    // Third curve
    path.quadraticBezierTo(
      size.width * 0.9, size.height * 0.4,
      size.width, size.height / 2,
    );

    // Draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
