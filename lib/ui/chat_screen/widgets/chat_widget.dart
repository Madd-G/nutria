import 'package:flutter/material.dart';
import 'widgets.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {super.key,
      required this.msg,
      required this.chatIndex,
      this.shouldAnimate = false});

  final String msg;
  final int chatIndex;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset(
              //   chatIndex == 0 ? AssetsManager.userImage : AssetsManager.botImage,
              //   height: 30,
              //   width: 30,
              // ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: chatIndex == 0
                    ? UserInput(
                        label: msg,
                      )
                    : AiAnswer(
                        msg: msg,
                        shouldAnimate: shouldAnimate,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
