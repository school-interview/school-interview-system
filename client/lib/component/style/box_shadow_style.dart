import 'package:client/constant/color.dart';
import 'package:flutter/material.dart';

/// Box Shadowのスタイル
class BoxShadowStyle {
  /// Shadow-Layer1 X:0 Y:1 ぼかし範囲:2 広がり:0
  /// Shadow-Layer2 X:0 Y:1 ぼかし範囲:3 広がり:1
  static List<BoxShadow> boxShadowStyle() {
    return <BoxShadow>[
      const BoxShadow(
        color: ColorDefinitions.boxShadowLayer1,
        offset: Offset(0, 1),
        blurRadius: 2,
        spreadRadius: 0,
      ),
      const BoxShadow(
        color: ColorDefinitions.boxShadowLayer2,
        offset: Offset(0, 1),
        blurRadius: 3,
        spreadRadius: 1,
      ),
    ];
  }

  static List<BoxShadow> chatBubbleShadowStyle() {
    return <BoxShadow>[
      const BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: Offset(2, 2),
      ),
    ];
  }
}
