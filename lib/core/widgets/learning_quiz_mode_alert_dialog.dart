import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../features/features.dart';
import '../core.dart';

class LearningQuizModeDialog extends StatefulWidget {
  const LearningQuizModeDialog({
    super.key,
    required this.examId,
    this.questionNumber,
    this.retake,
    this.downloadedUserMock,
    this.localization
  });
  final AppLocalizations? localization;
  final String examId;
  final int? questionNumber;
  final bool? retake;
  final DownloadedUserMock? downloadedUserMock;

  @override
  State<LearningQuizModeDialog> createState() => _LearningQuizModeDialogState();
}

class _LearningQuizModeDialogState extends State<LearningQuizModeDialog> {
  QuestionMode isLearningMode = QuestionMode.none;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(
        widget.localization!.exam_mode,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRadioButton(
            title: widget.localization!.learning_mode,
            description: widget.localization!.learning_mode_text,
            isSelected: isLearningMode == QuestionMode.learning,
            onTap: () {
              setState(() {
                isLearningMode = QuestionMode.learning;
              });
            },
          ),
          const SizedBox(height: 12),
          CustomRadioButton(
            title: widget.localization!.quiz_mode,
            description: widget.localization!.quiz_mode_text,
            isSelected: isLearningMode == QuestionMode.quiz,
            onTap: () {
              setState(() {
                isLearningMode = QuestionMode.quiz;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            )),
            onPressed: isLearningMode == QuestionMode.none
                ? null
                : () {
                    context.read<AlertDialogBloc>().add(
                          LearningQuizModeEvent(
                            examId: widget.examId,
                            questionMode: isLearningMode,
                            questionNumber: widget.questionNumber,
                            retake: widget.retake,
                            downloadedUserMock: widget.downloadedUserMock,
                          ),
                        );
                    Navigator.of(context).pop();
                  },
            child: Text(
              widget.localization!.start,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.isSelected,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final bool isSelected;
  final String title;
  final String description;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF18786A) : null,
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF18786A).withOpacity(.5)
                    : Colors.grey,
              ),
              shape: BoxShape.circle,
            ),
            child: isSelected
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                ),
                child: Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
