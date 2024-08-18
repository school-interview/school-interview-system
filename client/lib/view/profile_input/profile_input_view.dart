import 'package:client/component/input_text_field.dart';
import 'package:client/component/style/box_shadow_style.dart';
import 'package:client/constant/color.dart';
import 'package:client/constant/select_items.dart';
import 'package:client/generated/l10n.dart';
import 'package:client/view/avatar_select/avatar_select_view.dart';
import 'package:client/view_model/profile_input/profile_input_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileInputView extends ConsumerStatefulWidget {
  const ProfileInputView({super.key});

  @override
  ConsumerState<ProfileInputView> createState() => _ProfileInputView();
}

class _ProfileInputView extends ConsumerState<ProfileInputView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(profileInputViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: ColorDefinitions.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorDefinitions.secondaryColor,
        title: Text(S.of(context).startAppBarTitle),
        titleTextStyle: const TextStyle(
          color: ColorDefinitions.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
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
                    return null;
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
                    return null;
                  },
                  onChanged: (value) {
                    viewModel.setName(value);
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      // バリデーションが成功した場合にのみ画面遷移を行う
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AvatarSelectView(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: ColorDefinitions.accentColor,
                    minimumSize: const Size(100, 50),
                  ),
                  child: const Text("次へ"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 学科のプルダウンを作成するWidget
  Widget _buildSelectMajorPullDown(ProfileInputViewModel viewModel) {
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
        boxShadow: BoxShadowStyle.boxShadowStyle(),
      ),
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
        dropdownColor: Colors.white,
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
