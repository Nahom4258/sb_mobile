import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skill_bridge_mobile/core/core.dart';
import 'package:skill_bridge_mobile/features/question/presentation/bloc/bloc/general_chat_bloc.dart';
import 'package:skill_bridge_mobile/features/question/presentation/widgets/message_input_field_for_generalchat.dart';
import 'package:skill_bridge_mobile/features/question/presentation/widgets/message_widget__loading.dart';
import '../../../../core/utils/snack_bar.dart';
import '../widgets/message_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../features.dart';

class GeneralChatPage extends StatefulWidget {
  const GeneralChatPage({
    super.key,
    required this.pageName,
  });

  final String pageName;

  @override
  State<GeneralChatPage> createState() => _GeneralChatPageState();
}

class _GeneralChatPageState extends State<GeneralChatPage> {
  List<Message> chatMessages = [
    // Message(
    //   content: 'loading',
    //   isMessageFromUser: false,
    // ),
  ];

  bool _hasSentMessage = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onUserChatSubmit(String userMessage) {
      if (!_hasSentMessage) {
        setState(() {
          _hasSentMessage = true;
        });
      }
      setState(() {
        chatMessages.add(
          Message(content: userMessage, isMessageFromUser: true),
        );
      });
      print(chatMessages);
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    void onAIChatResponse({required String aiChat, String? tag}) {
      setState(() {
        chatMessages.add(
          Message(
            content: aiChat,
            isMessageFromUser: false,
            tag: tag,
          ),
        );
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    }

    return BlocListener<GeneralChatBloc, GeneralChatState>(
      listener: (context, state) {
        if (state is GeneralChatLoadingState) {
          onAIChatResponse(aiChat: "loading");
        }

        if (state is GeneralChatLoadedState) {
          chatMessages.removeAt(chatMessages.length - 1);
          onAIChatResponse(
            aiChat: state.chatResponse.messageResponse,
            tag: state.chatResponse.tag,
          );
        }

        if (state is GeneralChatFailedState) {
          if (state.failure is RequestOverloadFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar(state.failure.errorMessage));
          }
          chatMessages.removeAt(chatMessages.length - 1);
          onAIChatResponse(
              aiChat: 'An unkown error has occured, please try again...');
        }
        // else if (state is SendChatState &&
        //     state.status == ChatStatus.loading) {
        //   onAIChatResponse(state.chatResponse!.messageResponse);
        // }
      },
      child: buildWidget(onUserChatSubmit),
    );
  }

  Widget buildWidget(
    Function(String) onSubmit,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const ChatAppBarWidget(),
            !_hasSentMessage
                ? Container(
                  
                    child: Column(
                      children: [
                        SizedBox(height: 2.h,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            image: DecorationImage(image:AssetImage('assets/images/prof.png'))
                          ),
                          height: 120,
                          width: 120,
                          
                        ),
                        SizedBox(height: 2.h,),
                        Container(
                          width: 70.w,
                          child: Text(
                            'Hi there, I am Professor LearnAlot, How can I help you today?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      chatMessages.add(
                                        Message(
                                            content: 'How do I register for contest?',
                                            isMessageFromUser: true),
                                      );
                                    });
                                    context.read<GeneralChatBloc>().add(
                                          GeneralChatSendEvent(
                                            message:'How do I register for contest?',
                                            isFirstChat: true,
                                            chatHistory: [ChatHistory(human: "How do I regiser for contest?", ai: '')],
                                            pageName: widget.pageName,
                                          ),
                                        );
                                    onSubmit('');
                                  },
                                  child: Container(
                                    // height: 100,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Color.fromARGB(31, 91, 91, 91)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  136, 11, 11, 11),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                            ),
                                            child: Icon(
                                              Icons.navigation_rounded,
                                              color: Colors.white,
                                              size: 20.0,
                                            )),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'How do i register for contest?',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Navigation',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<GeneralChatBloc>().add(
                                          GeneralChatSendEvent(
                                            message:
                                                'What are the types of cells?',
                                            isFirstChat: true,
                                            chatHistory: [],
                                            pageName: widget.pageName,
                                          ),
                                        );
                                    onSubmit('What are the types of cells?');
                                  },
                                  child: Container(
                                    // height: 100,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Color.fromARGB(31, 91, 91, 91)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  136, 11, 11, 11),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                            ),
                                            child: Icon(
                                              Icons.biotech,
                                              color: Colors.white,
                                              size: 22.0,
                                            )),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'What are the types of cells?',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Study',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Container(
                      width: 100.w,
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 12),
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: chatMessages.isNotEmpty
                          ? Column(
                              children: List.generate(
                                chatMessages.length,
                                (index) =>
                                    chatMessages[index].content == 'loading'
                                        ? MessageWidgetLoading(
                                            isMyMessage: false,
                                            time: chatMessages[index].time,
                                          )
                                        : MessageWidget(
                                            messageContent:
                                                chatMessages[index].content,
                                            isMyMessage: chatMessages[index]
                                                .isMessageFromUser,
                                            time: chatMessages[index].time,
                                            tag: chatMessages[index].tag,
                                          ),
                              ),
                            )
                          : Container()
                      // : SizedBox(
                      //     height: 70.h,
                      //     child: const Column(
                      //       children: [
                      //         Align(
                      //           alignment: Alignment.center,
                      //           child: ChatWelcomeCard(),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      ),
                ),
              ),
            ),
            GeneralChatMessageInputField(
              isEnabled: chatMessages.isEmpty ||
                  chatMessages[chatMessages.length - 1].content != 'loading',
              chatMessages: chatMessages,
              pageName: widget.pageName,
              onSubmit: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
