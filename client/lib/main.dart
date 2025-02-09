import 'package:client/view/main/main_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(
    DevicePreview(
      builder: (_) => const ProviderScope(
        child: MainView(),
      ),
    ),
  );
}
