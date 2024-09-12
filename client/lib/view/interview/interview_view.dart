import 'package:client/component/custom_app_bar.dart';
import 'package:client/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InterviewView extends ConsumerStatefulWidget {
  const InterviewView({super.key});

  @override
  ConsumerState<InterviewView> createState() => _InterviewView();
}

class _InterviewView extends ConsumerState<InterviewView> {
  @override
  void initState() {
    super.initState();
    Future(() {
      // Add your initialization code here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorDefinitions.primaryColor,
      appBar: CustomAppBar().startAppBar(context),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _chatBubble("こんにちは！", false),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatBubble(String text, bool isSentByMe) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.green[100] : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: isSentByMe ? Radius.circular(16) : Radius.circular(0),
            bottomRight: isSentByMe ? Radius.circular(0) : Radius.circular(16),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}