import 'package:toast/toast.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';

class ToastApp {
  static const lengthLong = Toast.lengthLong;
  static const lengthShort = Toast.lengthShort;
  static const bottom = Toast.bottom;

  static init(context) {
    ToastContext toastContext = ToastContext();
    toastContext.init(context);
  }


  static void show(String message,
      {int duration = lengthShort, int gravity = bottom}) {
    Toast.show(message,
        duration: duration,
        gravity: gravity,
        backgroundColor: ColorsUtils.darkBlue,
        webTexColor: ColorsUtils.white);
  }
}
