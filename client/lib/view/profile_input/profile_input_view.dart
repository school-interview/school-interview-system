import 'package:client/component/button_component.dart';
import 'package:client/component/custom_app_bar.dart';
import 'package:client/component/input_text_field.dart';
import 'package:client/component/style/box_shadow_style.dart';
import 'package:client/constant/color.dart';
import 'package:client/constant/select_items.dart';
import 'package:client/infrastructure/shared_preference_manager.dart';
import 'package:client/notifier/profile_input_view/profile_input_view_notifier.dart';
import 'package:client/view/avatar_select/avatar_select_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// プロフィール入力画面
class ProfileInputView extends ConsumerStatefulWidget {
  const ProfileInputView({super.key, required this.name});

  final String name;

  @override
  ConsumerState<ProfileInputView> createState() => _ProfileInputView();
}

class _ProfileInputView extends ConsumerState<ProfileInputView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: ColorDefinitions.primaryColor,
        appBar: CustomAppBar().startAppBar(context),
        body: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        "さん",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildSelectMajorPullDown(),
                  const SizedBox(height: 15),
                  _buildSelectSemesterPullDown(),
                  const SizedBox(height: 15),
                  buildInputTextField(
                    labelText: "学籍番号",
                    hintText: "1234567",
                    limitText: 7,
                    validator: (value) {
                      if (!RegExp(r'^[0-9-]+$').hasMatch(value)) {
                        return '半角の数字のみを入力してください';
                      } else if (value.length != 7) {
                        return '7桁で入力してください';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final notifier =
                          ref.read(profileInputViewNotifierProvider.notifier);
                      notifier.saveStudentData(PrefKeys.studentId, value);
                    },
                  ),
                  const SizedBox(height: 30),
                  ButtonComponent().normalButton(
                    labelText: "次へ",
                    onTapButton: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        // バリデーションが成功した場合にのみ処理を行う
                        /// TODO ユーザーデータや学生データの要素がnullのときに代わりの値を入れるようにしているが、エラーアラートを表示し、ログイン画面に戻す必要がある
                        /// → 誤った学籍番号や学科などの情報で面談が進んでしまうため
                        final notifier =
                            ref.read(profileInputViewNotifierProvider.notifier);
                        final studentUpdate = await notifier.setStudentUpdate();
                        await notifier.putStudentInfo(studentUpdate);
                        // 非同期処理の後にウィジェットがまだ存在するかを確認
                        if (context.mounted) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const AvatarSelectView();
                            }),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 学科のプルダウンを作成するWidget
  Widget _buildSelectMajorPullDown() {
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
            final notifier =
                ref.read(profileInputViewNotifierProvider.notifier);
            notifier.saveStudentData(PrefKeys.department, value);
          }
        },
      ),
    );
  }

  /// 学期のプルダウンを作成するWidget
  Widget _buildSelectSemesterPullDown() {
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
                final notifier =
                    ref.read(profileInputViewNotifierProvider.notifier);
                notifier.saveStudentData(PrefKeys.semester, value);
                return;
              }
            }
          }
        },
      ),
    );
  }
}
