import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/contest/contest.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CustomContestQuestionListWidget extends StatefulWidget {
  const CustomContestQuestionListWidget({
    super.key,
    required this.questionMap,
    required this.addCustomContestQuestion,
  });

  final Map<String, int> questionMap;
  final void Function(Map<String, int>) addCustomContestQuestion;

  @override
  State<CustomContestQuestionListWidget> createState() => _CustomContestQuestionListWidgetState();
}

class _CustomContestQuestionListWidgetState extends State<CustomContestQuestionListWidget> {
  Map<String, int> questionMap = {};

  @override
  void initState(){
    super.initState();
    questionMap = Map.from(widget.questionMap);
  }
  
  void addCustomContestQuestion(Map<String, int> newQuestionMap) {
    setState(() {
      questionMap = newQuestionMap;
    });
    widget.addCustomContestQuestion(Map.from(newQuestionMap));
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
                        if(entries.isEmpty) 
                          EmptyListWidget(
                            message: 'Failed to load questions. Please click refresh.',
                            icon: 'assets/images/emptypage.svg',
                            showImage: false,
                            reloadCallBack: () {
                              context.read<FetchCustomContestSubjectsBloc>().add(
                                const FetchCustomContestSubjectsEvent(),
                              );
                            },
                          ),
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
                            addCustomContestQuestion(questionMap);
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
    final displayEntryList = questionMap.entries.where((entry) => (entry.value ?? 0)  > 0).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.questions,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        if(displayEntryList.isEmpty)
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset('assets/images/red_head_guy.png'),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.no_questions_added_yet,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: displayEntryList.length,
            itemBuilder: (context, index) {
              final entry = displayEntryList[index];
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black.withOpacity(0.2)
                      )
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                entry.key,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xFF18786A).withOpacity(0.2)
                                ),
                                child: Text(
                                  '${entry.value * 10} pts',
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF18786A)
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${entry.value} question${entry.value > 1 ? 's' : ''}',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          displayBottomModalSheet(questionMap.entries.toList());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFF18786A),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit, color: Colors.white, size: 20,),
                        ),
                      )
                    ]
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
                  ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              displayBottomModalSheet(questionMap.entries.toList());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF18786A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                    weight: 3,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    AppLocalizations.of(context)!.add_questions,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
