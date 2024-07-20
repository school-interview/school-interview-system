import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartView extends ConsumerStatefulWidget {
  const StartView({super.key});

  @override
  ConsumerState<StartView> createState() => _StartView();
}

class _StartView extends ConsumerState<StartView> {
  @override
  void initState() {
    super.initState();
    Future(() {
      // Add your initialization code here
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("学生面談(工学部) 〜学生情報入力画面〜"),
        ),
        body: const Center(
          child: Text(
            'start view',
          ),
        ),
      ),
    );
  }
}
