import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class ContestQuestionBottomNavBar extends StatelessWidget {
  const ContestQuestionBottomNavBar({
    super.key,
    required this.index,
    required this.categoryId,
    required this.totalQuestions,
    required this.goTo,
    required this.onSubmit,
    required this.changeCategory,
    required this.submittedCategories,
    required this.updateSubmittedCategories,
    required this.hasEnded,
    this.isCustomContest = false,
    this.categories = const [],
    this.customContestCategories = const [],
  });

  final int index;
  final String categoryId;
  final List<ContestCategory> categories;
  final int totalQuestions;
  final Function(int) goTo;
  final Function onSubmit;
  final Function(String) changeCategory;
  final Set<String> submittedCategories;
  final Function(String) updateSubmittedCategories;
  final bool hasEnded;
  final bool isCustomContest;
  final List<CustomContestCategory> customContestCategories;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(8),
                  value: categoryId,
                  iconSize: 0,
                  dropdownColor: Colors.white,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.menu, color: Colors.white),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color(0xFF1A7A6C),
                    icon: null,
                  ),
                  onChanged: (String? value) {
                    changeCategory(value!);
                    if (!hasEnded) {
                      if(isCustomContest){
                        context.read<FetchCustomContestQuestionsByCategoryBloc>().add(
                              FetchCustomContestQuestionsByCategoryEvent(
                                categoryId: value,
                              ),
                            );
                      } else {
                        context.read<FetchContestQuestionsByCategoryBloc>().add(
                          FetchContestQuestionsByCategoryEvent(
                            categoryId: value,
                          ),
                        );
                      }
                    } else {
                      if(isCustomContest) {
                        context.read<FetchCustomContestAnalysisByCategoryBloc>().add(
                          FetchCustomContestAnalysisByCategoryEvent(
                              categoryId: value));
                      } else{
                        context.read<FetchContestAnalysisByCategoryBloc>().add(
                          FetchContestAnalysisByCategoryEvent(
                              categoryId: value));
                      }
                    }
                    goTo(0);
                  },
                  selectedItemBuilder: (BuildContext context) {
                    if(isCustomContest){
                      return customContestCategories.map<Widget>((category) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A7A6C),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            category.subject,
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        );
                      }).toList();
                    } else {
                      return categories.map<Widget>((category) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A7A6C),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            category.subject,
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        );
                      }).toList();
                    }
                  },
                  items: isCustomContest
                      ? customContestCategories
                        .map<DropdownMenuItem<String>>(
                          (category) => DropdownMenuItem<String>(
                        enabled: !submittedCategories
                            .contains(category.id),
                        value: category.id,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  category.subject,
                                  style: GoogleFonts.poppins(
                                    color: category.id == categoryId
                                        ? const Color(0xFF1A7A6C)
                                        : Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (submittedCategories
                                    .contains(category.id))
                                  const Icon(Icons.check,
                                      color: Color(0xFF1A7A6C))
                              ],
                            ),
                            Text(
                              '${category.numberOfQuestions} ${AppLocalizations.of(context)!.question}${category.numberOfQuestions > 1 ? 's' : ''}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: category.id == categoryId
                                    ? const Color(0xFF1A7A6C)
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .toList()
                      : categories
                      .map<DropdownMenuItem<String>>(
                        (category) => DropdownMenuItem<String>(
                          enabled: !submittedCategories
                              .contains(category.categoryId),
                          value: category.categoryId,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    category.subject,
                                    style: GoogleFonts.poppins(
                                      color: category.categoryId == categoryId
                                          ? const Color(0xFF1A7A6C)
                                          : Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (submittedCategories
                                      .contains(category.categoryId))
                                    const Icon(Icons.check,
                                        color: Color(0xFF1A7A6C))
                                ],
                              ),
                              Text(
                                '${category.numberOfQuestion} ${AppLocalizations.of(context)!.question}${category.numberOfQuestion > 1 ? 's' : ''}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: category.categoryId == categoryId
                                      ? const Color(0xFF1A7A6C)
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              index == 0
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        goTo(index - 1);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 32,
                        color: Color(0xFF18786A),
                      ),
                    ),
              const SizedBox(width: 16),
              index == totalQuestions - 1
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF18786A),
                        foregroundColor: Colors.white,
                      ),
                      onPressed:
                          submittedCategories.contains(categoryId) && !hasEnded
                              ? null
                              : () {
                                  if (!hasEnded) {
                                    onSubmit();
                                  }
                                  // onSaveScore();
                                  updateSubmittedCategories(categoryId);
                                },
                      child: Text(
                        !hasEnded
                            ? submittedCategories.contains(categoryId)
                                ? AppLocalizations.of(context)!.submitted
                                : AppLocalizations.of(context)!.submit_bold
                            : AppLocalizations.of(context)!.done,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        goTo(index + 1);
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 32,
                        color: Color(0xFF18786A),
                      ),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
