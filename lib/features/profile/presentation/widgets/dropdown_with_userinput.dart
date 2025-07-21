import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/features/onboarding/presentation/bloc/schools_bloc/schols_bloc.dart';
import 'package:skill_bridge_mobile/features/onboarding/presentation/bloc/schools_bloc/schools_event.dart';
import 'package:skill_bridge_mobile/features/onboarding/presentation/bloc/schools_bloc/schools_state.dart';

class DropDownWithUserInput extends StatefulWidget {
  const DropDownWithUserInput({
    Key? key,
    required this.items,
    required this.lable,
    required this.hintText,
    required this.selectedCallback,
    required this.title,
    required this.scrollController,
  }) : super(key: key);

  final List<String> items;
  final String hintText;
  final String title;
  final String lable;
  final void Function(String?) selectedCallback;
  final ScrollController scrollController;

  @override
  _DropDownWithUserInputState createState() => _DropDownWithUserInputState();
}

class _DropDownWithUserInputState extends State<DropDownWithUserInput> {
  TextEditingController textController = TextEditingController();
  final focusNode = FocusNode();
  final layerLink = LayerLink();
  OverlayEntry? entry;
  List<String> items = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    items = widget.items; // Initialize with the provided items
    focusNode.addListener(_handleFocusChange);
    // Add the global focus manager listener
    FocusManager.instance.addListener(_handleGlobalFocusChange);
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusChange);
    _debounce?.cancel();
    // Remove the global focus manager listener
    FocusManager.instance.removeListener(_handleGlobalFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    if (focusNode.hasFocus) {
      showOverlay();
      Future.delayed(const Duration(milliseconds: 300), () {
        widget.scrollController.jumpTo(
          widget.scrollController.position.pixels + 200,
        );
      });
    } else {
      hideOverlay();
    }
  }

  // Global focus change handler
  void _handleGlobalFocusChange() {
    // Check if the primary focus is not this widget's focus node
    if (FocusManager.instance.primaryFocus != focusNode) {
      if (entry != null) {
        hideOverlay();
      }
    }
  }

  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    entry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // This GestureDetector fills the screen and detects taps outside the overlay
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // Close the overlay
                hideOverlay();
                // Unfocus the text field
                focusNode.unfocus();
              },
            ),
          ),
          // The overlay positioned at the correct place
          Positioned(
            width: size.width,
            bottom: 0,
            child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height - 2.h),
              child: buildOverlay(),
            ),
          ),
        ],
      ),
    );
    overlay?.insert(entry!);
  }

  Widget buildOverlay() {
    return Material(
      elevation: 2,
      child: Container(
        constraints: BoxConstraints(maxHeight: 40.h),
        child: BlocBuilder<SchoolBloc, SchoolState>(
          builder: (context, state) {
            if (state is SchoolsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SchoolsLoaded) {
              items = state.schools.map((e) => e.name).toList();
            } else if (state is SchoolsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              // Use initial items if no state change
              items = widget.items;
            }

            // Filter items based on text input
            final filteredItems = items
                .where((item) => item
                    .toLowerCase()
                    .contains(textController.text.toLowerCase()))
                .toList();

            if (filteredItems.isEmpty) {
              return Center(child: Text('No schools found'));
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return ListTile(
                  title: Text('$item ${widget.lable}'),
                  subtitle: const Divider(),
                  dense: true,
                  onTap: () {
                    widget.selectedCallback(item);
                    textController.text = item;
                    setState(() {
                      hideOverlay();
                      focusNode.unfocus();
                    });
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  void _onTextChanged(String val) {
    widget.selectedCallback(val);

    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (val.isNotEmpty) {
        // Dispatch the event to fetch schools from the bloc
        context
            .read<SchoolBloc>()
            .add(GetSchoolsEvent(searchParam: val.trim()));
      } else {
        // Use initial items when the input is empty
        setState(() {
          items = widget.items;
        });
      }
    });

    setState(() {
      if (val.isEmpty) {
        hideOverlay();
      } else {
        if (entry == null) {
          showOverlay();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: GoogleFonts.poppins(
            color: const Color(0xFF363636),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1,
            letterSpacing: -0.02,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1.h),
        CompositedTransformTarget(
          link: layerLink,
          child: TextField(
            style: TextStyle(fontFamily: 'Poppins'),
            focusNode: focusNode,
            controller: textController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  hideOverlay();
                },
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: .5.h,
              ),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFC4C4C4),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 87, 87, 87),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              hintText: widget.hintText,
            ),
            onChanged: _onTextChanged,
          ),
        ),
        SizedBox(height: 1.h),
      ],
    );
  }
}
