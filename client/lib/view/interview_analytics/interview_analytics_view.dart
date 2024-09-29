import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 要支援レベル画面
class InterviewAnalyticsView extends ConsumerStatefulWidget {
  const InterviewAnalyticsView({super.key});

  @override
  ConsumerState<InterviewAnalyticsView> createState() =>
      _InterviewAnalyticsView();
}

class _InterviewAnalyticsView extends ConsumerState<InterviewAnalyticsView> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      // initial logic
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
