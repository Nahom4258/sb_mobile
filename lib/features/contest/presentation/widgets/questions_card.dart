import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../features.dart';

class QuestionsCard extends StatelessWidget {
  const QuestionsCard({
    super.key,
    required this.customContestCategory,
    required this.isOwner,
    required this.isLastItem,
    this.displayEditButton = true,
  });

  final CustomContestCategory customContestCategory;
  final bool isOwner;
  final bool displayEditButton;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration:  BoxDecoration(
          border: Border(
            bottom: isLastItem ? BorderSide.none :  BorderSide(
              width: 1,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      customContestCategory.subject,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // const SizedBox(width: 4),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xFF18786A).withOpacity(.11),
                    //     borderRadius: BorderRadius.circular(4),
                    //   ),
                    //   child: Text(
                    //     '${customContestCategory.numberOfQuestions} pts',
                    //     style: GoogleFonts.poppins(
                    //       color: const Color(0xFF18786A),
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${customContestCategory.numberOfQuestions} questions',
                  style: GoogleFonts.poppins(),
                ),
              ],
            ),
            if(isOwner && displayEditButton)
              InkWell(
                onTap: (){

                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF18786A),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 16,),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
