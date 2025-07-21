import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '';

class CustomContestQuestionNotFoundWidget extends StatefulWidget {
  const CustomContestQuestionNotFoundWidget({
    super.key,
    required this.questionMap,
    required this.addCustomContestQuestion,
  });

  final Map<String, int> questionMap;
  final Function(Map<String, int>) addCustomContestQuestion;

  @override
  State<CustomContestQuestionNotFoundWidget> createState() => _CustomContestQuestionNotFoundWidgetState();
}

class _CustomContestQuestionNotFoundWidgetState extends State<CustomContestQuestionNotFoundWidget> {
  Map<String, int> questionMap = {};

  @override
  void initState() {
    super.initState();
    questionMap = Map.from(widget.questionMap);
  }

  void addNumberOfQuestion(String key, void Function(void Function()) setState) {
    setState(() {
      questionMap[key] = (questionMap[key] ?? 0) + 1;
    });
  }

  void subtractNumberOfQuestion(String key, void Function(void Function()) setState) {
    if((questionMap[key] ?? 0) > 0) {
      setState(() {
        questionMap[key] = (questionMap[key] ?? 0) - 1;
      });
    }
  }

  void displayBottomModalSheet(List<MapEntry<String, int>> entries) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 80.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24)
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Add Question',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You can simply add questions to your contest by selecting the subject and the number of questions you want to have under the subject.',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF9D9D9D),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final entry = entries[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  entry.key,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF6F7FC),
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          subtractNumberOfQuestion(entry.key, setState);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.remove,
                                            color: Color(0xFF18786A),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text('${questionMap[entry.key] ?? 0}', style: GoogleFonts.poppins(),),
                                      const SizedBox(width: 20),
                                      InkWell(
                                        onTap: () {
                                          addNumberOfQuestion(entry.key, setState);
                                          },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF18786A),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 16),
                          itemCount: entries.length,
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () {
                          widget.addCustomContestQuestion(questionMap);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF18786A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Add',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final entries = questionMap.entries.toList();
    return Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.asset('assets/images/red_head_guy.png'),
            const SizedBox(height: 8),
            Text(
              'No questions added yet',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
  }
}