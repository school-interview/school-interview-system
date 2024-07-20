import 'package:client/component/input_text_field.dart';
import 'package:client/constant/color.dart';
import 'package:client/constant/select_items.dart';
import 'package:client/view_model/start/start_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartView extends ConsumerStatefulWidget {
  const StartView({super.key});

  @override
  ConsumerState<StartView> createState() => _StartView();
}

class _StartView extends ConsumerState<StartView> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future(() {
      // Add your initialization code here
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(startViewModelProvider.notifier);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("学生面談(工学部)"),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  _buildSelectMajorPullDown(viewModel),
                  const SizedBox(height: 15),
                  buildInputTextField(
                    viewModel,
                    labelText: "学籍番号",
                    hintText: "1234567",
                    limitText: 7,
                    validator: (value) {
                      if (!RegExp(r'^[0-9-]+$').hasMatch(value)) {
                        return '数字のみを入力してください';
                      } else if (value.length != 7) {
                        return '7桁で入力してください';
                      }
                    },
                    onChanged: (value) {
                      viewModel.setSchoolNumber(value);
                    },
                  ),
                  const SizedBox(height: 15),
                  buildInputTextField(
                    viewModel,
                    labelText: "クラスー名列番号",
                    hintText: "1EP1-01",
                    onChanged: (value) {
                      viewModel.setClassColumnNumber(value);
                    },
                  ),
                  const SizedBox(height: 15),
                  buildInputTextField(
                    viewModel,
                    labelText: "氏名",
                    hintText: "金工 太郎",
                    validator: (value) {
                      // ひらがな、カタカナ、漢字、アルファベット、"ー"、"・"のみ
                      if (!RegExp(r'^[ぁ-んァ-ン一-龠a-zA-Zー・]+$').hasMatch(value)) {
                        return '使用できない文字が含まれています。';
                      }
                    },
                    onChanged: (value) {
                      viewModel.setName(value);
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      formKey.currentState?.validate();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: const Size(100, 50),
                    ),
                    child: const Text("次へ"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 学科のプルダウンを作成するWidget
  Widget _buildSelectMajorPullDown(StartViewModel viewModel) {
    const majorSelects = SelectItems.majors;
    List<DropdownMenuItem<String>> pullDownItems = [];
    for (int i = 0; i < majorSelects.length; i++) {
      DropdownMenuItem<String> newItem = DropdownMenuItem<String>(
        value: majorSelects[i],
        child: Text(majorSelects[i]),
      );
      pullDownItems.add(newItem);
    }

    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: ColorDefinitions.boxShadowLayer1,
              offset: Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: ColorDefinitions.boxShadowLayer2,
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ]),
      child: DropdownButtonFormField(
        items: pullDownItems,
        decoration: const InputDecoration(
          labelText: "学科",
          labelStyle: TextStyle(
            color: ColorDefinitions.formLabelTextColor,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
        ),
        validator: (value) {
          if (value == null) {
            return '選択してください。';
          }
          return null;
        },
        onChanged: (String? value) {
          if (value != null) {
            viewModel.setName(value);
          }
        },
      ),
    );
  }
}
