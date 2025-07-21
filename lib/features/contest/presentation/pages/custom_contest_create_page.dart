import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_bridge_mobile/core/widgets/three_bounce_spinkit.dart';
import 'package:skill_bridge_mobile/features/contest/presentation/widgets/custom_contest_question_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../features.dart';
import '../../../../core/core.dart';

class CustomContestCreatePage extends StatefulWidget {
  const CustomContestCreatePage({
    super.key,
    this.customContestDetail,
  });

  final CustomContestDetail? customContestDetail;

  @override
  State<CustomContestCreatePage> createState() =>
      _CustomContestCreatePageState();
}

class _CustomContestCreatePageState extends State<CustomContestCreatePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _contestNameController;
  late TextEditingController _contestDescriptionController;
  Map<String, int> questionMap = {};
  DateTime? _startDateTime;
  DateTime? _endDateTime;

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final DateFormat _timeFormat = DateFormat('HH:mm');

  @override
  void initState() {
    super.initState();
    _contestNameController = TextEditingController();
    _contestDescriptionController = TextEditingController();

    if(widget.customContestDetail != null) {
      _contestNameController.text = widget.customContestDetail!.title;
      _contestDescriptionController.text = widget.customContestDetail!.description;
      _startDateTime = widget.customContestDetail!.startsAt;
      _endDateTime = widget.customContestDetail!.endsAt;
      for(var category in widget.customContestDetail!.customContestCategories) {
        questionMap[category.subject] = category.numberOfQuestions;
      }
    }
    context.read<FetchCustomContestSubjectsBloc>().add(const FetchCustomContestSubjectsEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _contestNameController.dispose();
    _contestDescriptionController.dispose();
  }

  void addCustomContestQuestion(Map<String, int> newQuestionMap) {
    setState(() {
      questionMap = Map.from(newQuestionMap);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_startDateTime == null || _endDateTime == null) {
        _showErrorDialog(context, AppLocalizations.of(context)!.both_start_and_end_dates_must_be_selected);
        return;
      }

      if (_startDateTime!.isAfter(_endDateTime!)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$_startDateTime>$_endDateTime')));
        _showErrorDialog(context, 'Start date-time must be before end date-time.');
        return;
      }

      if (_startDateTime!.isBefore(DateTime.now()) || _endDateTime!.isBefore(DateTime.now())) {
        _showErrorDialog(context, 'Dates must be in the future.');
        return;
      }

      if(widget.customContestDetail == null){
        context.read<CreateCustomContestBloc>().add(
              CreateCustomContestEvent(
                params: CreateCustomContestParams(
                  title: _contestNameController.text.trim(),
                  description: _contestDescriptionController.text.trim(),
                  startsAt: _startDateTime!,
                  endsAt: _endDateTime!,
                  questions: questionMap,
                ),
              ),
            );
      } else {
        context.read<UpdateCustomContestBloc>().add(
          UpdateCustomContestEvent(
            params: UpdateCustomContestParams(
              id: widget.customContestDetail?.customContestId ?? '',
              title: _contestNameController.text.trim(),
              description: _contestDescriptionController.text.trim(),
              startsAt: _startDateTime!,
              endsAt: _endDateTime!,
              questions: questionMap,
            ),
          ),
        );
      }
    }
  }


  Future<void> _selectDateTime(BuildContext context, bool isStartDate) async {
    DateTime initialDate = DateTime.now();
    if (isStartDate && _startDateTime != null) {
      initialDate = _startDateTime!;
    } else if (!isStartDate && _endDateTime != null) {
      initialDate = _endDateTime!;
    }

    // Show Date Picker
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2125),
    );

    if (selectedDate != null) {
      // Show Time Picker
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (selectedTime != null) {
        final selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        if (isStartDate) {
          if (selectedDateTime.isBefore(DateTime.now())) {
            // Show error if start date-time is before now
            _showErrorDialog(context, 'Start date-time must be in the future.');
          } else if (_endDateTime != null && selectedDateTime.isAfter(_endDateTime!)) {
            // Show error if start date-time is after end date-time
            _showErrorDialog(context, 'Start date-time must be before end date-time.');
          } else {
            setState(() {
              _startDateTime = selectedDateTime;
            });
          }
        } else {
          if (selectedDateTime.isBefore(DateTime.now())) {
            // Show error if end date-time is before now
            _showErrorDialog(context, 'End date-time must be in the future.');
          } else if (_startDateTime != null && selectedDateTime.isBefore(_startDateTime!)) {
            // Show error if end date-time is before start date-time
            _showErrorDialog(context, 'End date-time must be after start date-time.');
          } else {
            setState(() {
              _endDateTime = selectedDateTime;
            });
          }
        }
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Date-Time', style: GoogleFonts.poppins(),),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateCustomContestBloc, CreateCustomContestState>(
          listener: (context, state) {
            if(state is CreateCustomContestLoading) {}
            else if(state is CreateCustomContestLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFF18786A),
                  content: Text(
                    'Custom contest created successfully',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  behavior: SnackBarBehavior.floating,
                )
              );
              context.read<FetchUpcomingCustomContestBloc>().add(
                const FetchUpcomingCustomContestEvent(),
              );
              context.read<FetchPreviousCustomContestBloc>().add(
                const FetchPreviousCustomContestEvent(),
              );
              context.pop();
            }
            else if(state is CreateCustomContestFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.redAccent,
                    content: Text(
                        'Failed to create custom contest',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                    ),
                )
              );
            }
          },
        ),
        BlocListener<UpdateCustomContestBloc, UpdateCustomContestState>(
          listener: (context, state) {
            if(state is UpdateCustomContestLoading) {}
            else if(state is UpdateCustomContestLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: const Color(0xFF18786A).withOpacity(0.7),
                      content: Text(
                        'Custom contest updated successfully',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ))
              );
              context.read<FetchUpcomingCustomContestBloc>().add(
                const FetchUpcomingCustomContestEvent(),
              );
              context.read<FetchPreviousCustomContestBloc>().add(
                const FetchPreviousCustomContestEvent(),
              );
              context.pop();
            }
            else if(state is UpdateCustomContestFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text(
                      'Failed to update custom contest',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                    ),
                  )
              );
            }
          },
        ),
      ],
      child: BlocBuilder<FetchCustomContestSubjectsBloc, FetchCustomContestSubjectsState>(
          builder: (context, state) {
            if (state is FetchCustomContestSubjectsLoaded) {
              final subjects = state.customContestSubjects;
              for(var subject in subjects) {
                if(!questionMap.containsKey(subject)) {
                  questionMap[subject] = 0;
                }
              }
            }

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                actions: [
                  InkWell(
                    onTap: _submitForm,
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF18786A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: BlocBuilder<CreateCustomContestBloc, CreateCustomContestState>(
                        builder: (context, state) {
                          if(state is CreateCustomContestLoading) {
                            return const SizedBox(
                              height: 20,
                              child:  ThreeBounceSpinkit(),
                            );
                          }
                          return Text(
                            widget.customContestDetail == null ? 'Create' : 'Edit',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create your own contest and complete with your friends.',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Contest Name',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  CustomTextFormField(
                                    controller: _contestNameController,
                                    validator: (val) {
                                      return validateCustomContestName(val, context);
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Contest Description',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 20.h,
                                    child: CustomTextFormField(
                                      controller: _contestDescriptionController,
                                      validator: (val) {
                                        return validateCustomContestDescription(val, context);
                                      },
                                      textInputType: TextInputType.multiline,
                                      expands: true,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Start Date & Time:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const  SizedBox(height: 8),
                                        // ElevatedButton(
                                        //   onPressed: () => _selectDateTime(context, true),
                                        //   child: Text(
                                        //     _startDateTime == null
                                        //         ? 'Select Start Date & Time'
                                        //         : '${_dateFormat.format(_startDateTime!)} ${_timeFormat.format(_startDateTime!)}',
                                        //   ),
                                        // ),
                                        InkWell(
                                          onTap: () => _selectDateTime(context, true),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: const Color(0xFF18786A).withOpacity(0.1),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.date_range),
                                                      const SizedBox(width: 12),
                                                      Text(
                                                        _startDateTime == null
                                                            ? 'Select Start Date & Time'
                                                            : '${_dateFormat.format(_startDateTime!)} ${_timeFormat.format(_startDateTime!)}',
                                                        style: GoogleFonts.poppins(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'End Date & Time:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        InkWell(
                                          onTap: () => _selectDateTime(context, false),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: const Color(0xFF18786A).withOpacity(0.1),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.date_range),
                                                      const SizedBox(width: 12),
                                                      Text(
                                                        _endDateTime == null
                                                            ? 'Select End Date & Time'
                                                            : '${_dateFormat.format(_endDateTime!)} ${_timeFormat.format(_endDateTime!)}',
                                                        style: GoogleFonts.poppins(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // ElevatedButton(
                                        //   onPressed: () => _selectDateTime(context, false),
                                        //   child: Text(
                                        //     _endDateTime == null
                                        //         ? 'Select End Date & Time'
                                        //         : '${_dateFormat.format(_endDateTime!)} ${_timeFormat.format(_endDateTime!)}',
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  if(state is FetchCustomContestSubjectsLoaded)
                                    CustomContestQuestionListWidget(
                                      questionMap: questionMap,
                                      addCustomContestQuestion: (newCustomContestQuestion) => addCustomContestQuestion(newCustomContestQuestion),
                                    ),
                                  if(state is FetchCustomContestSubjectsFailed)
                                    Align(
                                      alignment: Alignment.center,
                                      child: EmptyListWidget(
                                        message: 'Failed to load questions. Please click refresh.',
                                        icon: 'assets/images/emptypage.svg',
                                        showImage: false,
                                        reloadCallBack: () {
                                          context.read<FetchCustomContestSubjectsBloc>().add(
                                            const FetchCustomContestSubjectsEvent(),
                                          );
                                        },
                                      ),
                                    ),
                                  if(state is FetchCustomContestSubjectsLoading)
                                    Center(
                                      child: Shimmer.fromColors(
                                        direction: ShimmerDirection.ltr,
                                        baseColor: const Color.fromARGB(255, 236, 235, 235),
                                        highlightColor: const Color(0xFFF9F8F8),
                                        child: Container(
                                          width: 90.w,
                                          height: 10.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
