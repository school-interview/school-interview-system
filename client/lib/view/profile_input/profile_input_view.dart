import 'package:client/component/button_component.dart';
import 'package:client/component/custom_app_bar.dart';
import 'package:client/component/input_text_field.dart';
import 'package:client/component/style/box_shadow_style.dart';
import 'package:client/constant/color.dart';
import 'package:client/constant/select_items.dart';
import 'package:client/notifier/profile_input_view/profile_input_view_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileInputView extends ConsumerStatefulWidget {
  const ProfileInputView({super.key});

  @override
  ConsumerState<ProfileInputView> createState() => _ProfileInputView();
}

class _ProfileInputView extends ConsumerState<ProfileInputView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(profileInputViewNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: ColorDefinitions.primaryColor,
      appBar: CustomAppBar().startAppBar(context),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _buildSelectMajorPullDown(),
                const SizedBox(height: 15),
                _buildSelectSemesterPullDown(notifier),
                const SizedBox(height: 15),
                buildInputTextField(
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
                    notifier.setStudentId(value);
                  },
                ),
                const SizedBox(height: 15),
                buildInputTextField(
                  labelText: "クラスー名列番号",
                  hintText: "1EP1-01",
                  onChanged: (value) {
                    // TODO 名列番号の処理
                  },
                ),
                const SizedBox(height: 15),
                buildInputTextField(
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
                    notifier.setName(value);
                  },
                ),
                const SizedBox(height: 30),
                ButtonComponent().normalButton(
                  labelText: "次へ",
                  onTapButton: () {
                    if (formKey.currentState?.validate() ?? false) {
                      // バリデーションが成功した場合にのみ処理を行う
                      notifier.postUserInfo();
                      context.push("/avatar-select");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 学科のプルダウンを作成するWidget
  Widget _buildSelectMajorPullDown() {
    final notifier = ref.read(profileInputViewNotifierProvider.notifier);

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
            notifier.setDepartment(value);
          }
        },
      ),
    );
  }

  /// 学期のプルダウンを作成するWidget
  Widget _buildSelectSemesterPullDown(ProfileInputViewNotifier viewModel) {
    const semesterSelects = SelectItems.semesters;
    List<DropdownMenuItem<String>> pullDownItems = [];
    semesterSelects.forEach((key, value) {
      DropdownMenuItem<String> newItem = DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
      pullDownItems.add(newItem);
    });
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
          labelText: "学期",
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
            for (var item in semesterSelects.entries) {
              if (item.value == value) {
                viewModel.setSemester(item.key);
                return;
              }
            }
          }
        },
      ),
    );
  }
}
