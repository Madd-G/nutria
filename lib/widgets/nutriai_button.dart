import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import '../blocs/blocs.dart';
import '../ui/chat_screen/screen/chat_screen.dart';

class NutriAIButton extends StatelessWidget {
  const NutriAIButton({super.key, required this.mainWidget, this.screenHeight});

  final Widget mainWidget;
  final double? screenHeight;

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      mainScreenWidget: mainWidget,
      screenHeight: screenHeight,
      floatingWidget: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.primary,
        tooltip: 'Hello, may I help you?',
        onPressed: () {
          if (FirebaseAuth.instance.currentUser?.uid == null) {
            context.read<AuthCubit>().signInWithGoogle(context).then(
                (value) async => await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatScreen())));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ChatScreen()));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/AI.png',
          ),
        ),
      ),
      floatingWidgetWidth: 55,
      floatingWidgetHeight: 55,
    );
  }
}
